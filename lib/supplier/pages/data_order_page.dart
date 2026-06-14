import 'package:flutter/material.dart';

class DataOrderPage extends StatelessWidget {
  const DataOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Order - Permintaan dari SPPG'),
         titleTextStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF42A5F5),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Data Order Page - Coming Soon'),
      ),
    );
  }
}