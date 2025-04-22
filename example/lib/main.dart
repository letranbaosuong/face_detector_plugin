import 'dart:async';
import 'dart:io';

import 'package:face_detector_plugin/face_detector_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const FaceDetectionExample());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _faceDetectorPlugin = FaceDetectorPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _faceDetectorPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(child: Text('Running on: $_platformVersion\n')),
      ),
    );
  }
}

class FaceDetectionExample extends StatefulWidget {
  const FaceDetectionExample({super.key});

  @override
  FaceDetectionExampleState createState() => FaceDetectionExampleState();
}

class FaceDetectionExampleState extends State<FaceDetectionExample> {
  File? _image;
  List<Map<String, dynamic>> _faces = [];
  bool _isProcessing = false;
  final picker = ImagePicker();
  final _faceDetectorPlugin = FaceDetectorPlugin();

  Future<void> _pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _faces = [];
        _isProcessing = true;

        // Phát hiện khuôn mặt
        final faces = await _faceDetectorPlugin.detectFaces(_image!.path);

        setState(() {
          _faces = faces;
          _isProcessing = false;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Face Detection Demo')),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_image != null) ...[
                  Center(
                    child: SizedBox(
                      width: 250,
                      height: 250,
                      child: Stack(
                        children: [
                          Image.file(
                            _image!,
                            width: 250,
                            height: 250,
                            fit: BoxFit.contain,
                          ),
                          // CustomPaint(
                          //   painter: FaceMarkerPainter(_faces),
                          //   size: Size(250, 250),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Phát hiện ${_faces.length} khuôn mặt'),
                ] else
                  Text('Chưa chọn ảnh'),
                SizedBox(height: 20),

                if (_isProcessing)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Chọn ảnh'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FaceMarkerPainter extends CustomPainter {
  final List<Map<String, dynamic>> faces;

  FaceMarkerPainter(this.faces);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0
          ..color = Colors.red;

    for (var face in faces) {
      final rect = Rect.fromLTWH(
        face['x'] as double,
        face['y'] as double,
        face['width'] as double,
        face['height'] as double,
      );

      canvas.drawRect(rect, paint);

      // Vẽ các điểm đặc trưng nếu có
      final pointPaint =
          Paint()
            ..color = Colors.blue
            ..strokeWidth = 4;

      if (face.containsKey('leftEyeX')) {
        canvas.drawCircle(
          Offset(face['leftEyeX'] as double, face['leftEyeY'] as double),
          3,
          pointPaint,
        );
      }

      if (face.containsKey('rightEyeX')) {
        canvas.drawCircle(
          Offset(face['rightEyeX'] as double, face['rightEyeY'] as double),
          3,
          pointPaint,
        );
      }

      if (face.containsKey('mouthX')) {
        canvas.drawCircle(
          Offset(face['mouthX'] as double, face['mouthY'] as double),
          3,
          Paint()
            ..color = Colors.green
            ..strokeWidth = 4,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
