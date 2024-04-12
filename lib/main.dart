import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:camera_web/camera_web.dart';


void main() {
  runApp(const FlashlightApp());
}

class FlashlightApp extends StatefulWidget {
  const FlashlightApp({super.key});

  @override
  FlashlightAppState createState() => FlashlightAppState();
}

class FlashlightAppState extends State<FlashlightApp> {
  CameraController? _controller;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      _controller = CameraController(cameras.first, ResolutionPreset.low);
      await _controller!.initialize();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _toggleFlashlight() {
    if (_controller != null) {
      if (_isFlashOn) {
        _controller!.setFlashMode(FlashMode.off);
      } else {
        _controller!.setFlashMode(FlashMode.torch);
      }
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flashlight App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: _isFlashOn ? const Icon(Icons.flash_off) : const Icon(Icons.flash_on),
                onPressed: _toggleFlashlight,
              ),
              Text(_isFlashOn ? 'Flashlight On' : 'Flashlight Off'),
            ],
          ),
        ),
      ),
    );
  }
}
