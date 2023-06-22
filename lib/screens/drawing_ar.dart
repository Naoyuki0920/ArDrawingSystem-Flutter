import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class DrawingAR extends StatelessWidget {
  const DrawingAR({super.key});

  @override
  Widget build(BuildContext context) {
    return ModelViewer(
      src: 'https://modelviewer.dev/shared-assets/models/NeilArmstrong.glb',
      ar: true,
      autoRotate: true,
      cameraControls: true,
    );
  }
}
