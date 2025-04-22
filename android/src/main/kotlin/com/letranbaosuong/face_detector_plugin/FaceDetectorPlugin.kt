package com.letranbaosuong.face_detector_plugin

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.PointF
import android.media.FaceDetector
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File

/** FaceDetectorPlugin */
class FaceDetectorPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "face_detector_plugin")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }

            "detectFaces" -> {
                val imagePath = call.argument<String>("imagePath")
                if (imagePath == null) {
                    result.error("INVALID_ARGS", "Đường dẫn hình ảnh không được cung cấp", null)
                    return
                }

                try {
                    val faces = detectFaces(imagePath)
                    result.success(faces)
                } catch (e: Exception) {
                    result.error(
                        "DETECTION_ERROR",
                        "Lỗi khi phát hiện khuôn mặt: ${e.message}",
                        null
                    )
                }
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    private fun detectFaces(imagePath: String): List<Map<String, Any>> {
        val file = File(imagePath)
        if (!file.exists()) {
            throw Exception("File không tồn tại")
        }

        // Tải và chuyển đổi bitmap sang RGB_565 (bắt buộc cho FaceDetector)
        val options = BitmapFactory.Options().apply {
            inPreferredConfig = Bitmap.Config.RGB_565
        }

        var bitmap = BitmapFactory.decodeFile(imagePath, options)
        if (bitmap.config != Bitmap.Config.RGB_565) {
            bitmap = bitmap.copy(Bitmap.Config.RGB_565, true)
        }

        // Số khuôn mặt tối đa có thể phát hiện
        val maxFaces = 10

        // Khởi tạo FaceDetector
        val detector = FaceDetector(bitmap.width, bitmap.height, maxFaces)
        val faces = arrayOfNulls<FaceDetector.Face>(maxFaces)

        // Thực hiện phát hiện khuôn mặt
        val facesFound = detector.findFaces(bitmap, faces)

        val facesList = mutableListOf<Map<String, Any>>()

        for (i in 0 until facesFound) {
            val face = faces[i] ?: continue

            val midPoint = PointF()
            face.getMidPoint(midPoint)

            // Tính toán tọa độ hình chữ nhật dựa trên điểm giữa và độ tự tin
            val eyeDistance = face.eyesDistance()
            val confidence = face.confidence()

            // Ước tính kích thước khuôn mặt dựa trên khoảng cách giữa hai mắt
            val faceWidth = eyeDistance * 2.5f
            val faceHeight = eyeDistance * 3.5f

            val faceMap = mapOf(
                "id" to i,
                "x" to (midPoint.x - faceWidth / 2),
                "y" to (midPoint.y - faceHeight / 2),
                "width" to faceWidth,
                "height" to faceHeight,
                "confidence" to confidence,
                "eyesDistance" to eyeDistance,
                "midPointX" to midPoint.x,
                "midPointY" to midPoint.y
            )

            facesList.add(faceMap)
        }

        return facesList
    }


    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
