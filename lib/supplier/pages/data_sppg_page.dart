import 'package:flutter/material.dart';

class DataSPPGPage extends StatelessWidget {
  const DataSPPGPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data SPPG'),
         titleTextStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF42A5F5),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Data SPPG Page - Coming Soon'),
      ),
    );
  }
}