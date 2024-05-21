import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class ModelViewerScreen extends StatefulWidget {
  const ModelViewerScreen({super.key});

  @override
  State<ModelViewerScreen> createState() => _ModelViewerScreenState();
}

class _ModelViewerScreenState extends State<ModelViewerScreen> {
  //Create controller object to control 3D model.
  Flutter3DController controller = Flutter3DController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Flutter3DViewer(
        progressBarColor: Colors.blue,
        controller: controller,
        src: 'assets/models/shoes.glb',
      ),
    );
  }
}
