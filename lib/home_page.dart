import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_scene/camera.dart';
import 'package:flutter_scene/node.dart';
import 'package:flutter_scene/scene.dart';
import 'package:my_3d_app/buttons_widget.dart';
import 'package:my_3d_app/scene_painter.dart';

import 'package:vector_math/vector_math.dart' as vector;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  Scene scene = Scene();
  double elapsedSeconds = 0;

  double _previousDx = 0;
  double _previousDy = 0;

  bool isMobile = Platform.isIOS || Platform.isAndroid;

  Node? modelNode;

  @override
  void initState() {
    super.initState();

    createTicker((elapsed) {
      setState(() {
        elapsedSeconds = elapsed.inMilliseconds.toDouble() / 1000;
      });
    }).start();

    Node.fromAsset('assets/models/flutter_logo_baked.model').then((model) {
      model.name = 'Flutter';
      scene.add(model);
      modelNode = scene.root.children.firstWhere((node) => node.name == 'Flutter');
    });
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (!isMobile) {
      return;
    }

    final dx = details.localPosition.dx;
    final dy = details.localPosition.dy;

    setState(() {
      // Calculate the change in position
      final deltaX = dx - _previousDx;
      final deltaY = dy - _previousDy;

      // Convert delta values to rotation angles
      final rotationX = -deltaX * 0.01;
      final rotationY = deltaY * 0.01;

      // Create rotation matrices
      final rotationMatrixX = vector.Matrix4.rotationX(rotationX);
      final rotationMatrixY = vector.Matrix4.rotationY(rotationY);

      // Apply rotations: Y first then X to ensure proper rotation order
      final rotationMatrix = rotationMatrixY * rotationMatrixX;

      // Apply the rotation to the model
      modelNode?.localTransform =
          rotationMatrix * (modelNode?.localTransform ?? vector.Matrix4.identity());

      // Update previous touch positions
      _previousDx = dx;
      _previousDy = dy;
    });
  }

  void _handleUpPress() {
    setState(() {
      final rotationMatrix = vector.Matrix4.rotationX(400 * 0.001);
      modelNode?.localTransform =
          rotationMatrix * (modelNode?.localTransform ?? vector.Matrix4.identity());
    });
  }

  void _handleDownPress() {
    setState(() {
      final rotationMatrix = vector.Matrix4.rotationX(-400 * 0.001);
      modelNode?.localTransform =
          rotationMatrix * (modelNode?.localTransform ?? vector.Matrix4.identity());
    });
  }

  void _handleLeftPress() {
    setState(() {
      final rotationMatrix = vector.Matrix4.rotationY(400 * 0.001);
      modelNode?.localTransform =
          rotationMatrix * (modelNode?.localTransform ?? vector.Matrix4.identity());
    });
  }

  void _handleRightPress() {
    setState(() {
      final rotationMatrix = vector.Matrix4.rotationY(-400 * 0.001);
      modelNode?.localTransform =
          rotationMatrix * (modelNode?.localTransform ?? vector.Matrix4.identity());
    });
  }

  @override
  Widget build(BuildContext context) {
    final painter = ScenePainter(
      scene: scene,
      camera: PerspectiveCamera(),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          modelNode?.localTransform = vector.Matrix4.identity();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.restart_alt),
      ),
      body: Stack(
        children: [
          Center(
            child: GestureDetector(
              onPanUpdate: (details) => _handlePanUpdate(details),
              onPanEnd: (details) {
                // Reset previous touch positions after swipe ends
                _previousDx = 0;
                _previousDy = 0;
              },
              child: CustomPaint(
                painter: painter,
                size: Size(
                  MediaQuery.of(context).size.width * 0.8,
                  MediaQuery.of(context).size.height * 0.7,
                ),
              ),
            ),
          ),
          if (!isMobile)
            Positioned(
              bottom: 20,
              left: 20,
              child: DPadControl(
                onUpPress: () => _handleUpPress(),
                onDownPress: () => _handleDownPress(),
                onLeftPress: () => _handleLeftPress(),
                onRightPress: () => _handleRightPress(),
              ),
            ),
        ],
      ),
    );
  }
}
