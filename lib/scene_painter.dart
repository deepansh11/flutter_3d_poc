import 'package:flutter/material.dart';
import 'package:flutter_scene/camera.dart';
import 'package:flutter_scene/scene.dart';

class ScenePainter extends CustomPainter {
  final Scene scene;

  final Camera camera;

  const ScenePainter({required this.scene, required this.camera});

  @override
  void paint(Canvas canvas, Size size) {
    scene.render(camera, canvas, viewport: Offset.zero & size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
