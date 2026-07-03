import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'salah_screen.dart';

class WuduScreen extends StatefulWidget {
  const WuduScreen({super.key});

  @override
  State<WuduScreen> createState() => _WuduScreenState();
}

class _WuduScreenState extends State<WuduScreen> {
  CameraController? _controller;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _controller = CameraController(cameras[0], ResolutionPreset.medium);
        await _controller!.initialize();
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vudu Kontrolü')),
      body: Column(
        children: [
          Expanded(
            child: _controller != null && _controller!.value.isInitialized
                ? CameraPreview(_controller!)
                : const Center(child: CircularProgressIndicator()),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Kamerayı açın ve adım adım vudu alın.\nTamamladığınızda butona basın.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SalahScreen()),
                );
              },
              child: const Text('Vudu Tamamlandı → Namaza Başla'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}