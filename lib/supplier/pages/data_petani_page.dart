import 'package:flutter/material.dart';

class DataPetaniPage extends StatelessWidget {
  const DataPetaniPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Petani/UMKM'),
         titleTextStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF42A5F5),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Data Petani/UMKM Page - Coming Soon'),
      ),
    );
  }
}