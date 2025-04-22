import Flutter
import UIKit

public class FaceDetectorPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "face_detector_plugin", binaryMessenger: registrar.messenger())
        let instance = FaceDetectorPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "detectFaces":
            guard let args = call.arguments as? [String: Any],
                  let imagePath = args["imagePath"] as? String else {
                result(FlutterError(code: "INVALID_ARGS", message: "Invalid arguments", details: nil))
                return
            }
            
            detectFaces(imagePath: imagePath, completion: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func detectFaces(imagePath: String, completion: @escaping FlutterResult) {
        guard let uiImage = UIImage(contentsOfFile: imagePath),
              let ciImage = CIImage(image: uiImage) else {
            completion(FlutterError(code: "IMAGE_LOAD_ERROR", message: "Không thể tải hình ảnh", details: nil))
            return
        }
        
        // Tạo detector với độ chính xác cao
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces = faceDetector?.features(in: ciImage) as? [CIFaceFeature] ?? []
        
        // Chuyển đổi tọa độ Core Image sang tọa độ thông thường
        let ciImageSize = ciImage.extent.size
        var transform = CGAffineTransform(scaleX: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -ciImageSize.height)
        
        var facesResult: [[String: Any]] = []
        
        for (index, face) in faces.enumerated() {
            let faceViewBounds = face.bounds.applying(transform)
            
            var faceData: [String: Any] = [
                "id": index,
                "x": faceViewBounds.origin.x,
                "y": faceViewBounds.origin.y,
                "width": faceViewBounds.width,
                "height": faceViewBounds.height
            ]
            
            if face.hasLeftEyePosition {
                let leftEyePoint = face.leftEyePosition.applying(transform)
                faceData["leftEyeX"] = leftEyePoint.x
                faceData["leftEyeY"] = leftEyePoint.y
            }
            
            if face.hasRightEyePosition {
                let rightEyePoint = face.rightEyePosition.applying(transform)
                faceData["rightEyeX"] = rightEyePoint.x
                faceData["rightEyeY"] = rightEyePoint.y
            }
            
            if face.hasMouthPosition {
                let mouthPoint = face.mouthPosition.applying(transform)
                faceData["mouthX"] = mouthPoint.x
                faceData["mouthY"] = mouthPoint.y
            }
            
            facesResult.append(faceData)
        }
        
        completion(facesResult)
    }
    
}
