import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

class PantallaCamara extends StatefulWidget {
  const PantallaCamara({super.key});

  static const String route = '/registro/camara';
  @override
  State<PantallaCamara> createState() => _PantallaCamaraState();
}

class _PantallaCamaraState extends State<PantallaCamara> with WidgetsBindingObserver, TickerProviderStateMixin {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = CameraController(
    CameraDescription(
      name: 'Foto campo', 
      lensDirection: CameraLensDirection.back, 
      sensorOrientation: 270
    ), 
    ResolutionPreset.high,
    enableAudio: false,
    );
    _initializeControllerFuture = _controller.initialize().then((_) {
      setState(() {
        
      });
    });
    
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      //_initializeCameraController(cameraController.description);
    }
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(child: ClipRRect(
              child: SizedOverflowBox(
                size: Size(size.width, size.height),
                alignment: Alignment.center,
                child: CameraPreview(_controller),
                ),
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(18.ss),
                child: IconButton(
                  onPressed: () async {
                    final image = await _controller.takePicture();
                    if(!mounted) return;
                    Navigator.pop(context, File(image.path));
                  }, 
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    size: 50,
                  )
                ),
              ),
            )
          ],
        )
      )
    );
  }
}