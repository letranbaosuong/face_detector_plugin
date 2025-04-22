# face_detector_plugin

A new face detector plugin.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Example

```
import 'dart:async';
import 'dart:io';

import 'package:face_detector_plugin/face_detector_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const FaceDetectionExample());
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
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Detect ${_faces.length} face'),
                ] else
                  Text('No photo selected'),
                SizedBox(height: 20),

                if (_isProcessing)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Select photo'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```
