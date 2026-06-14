import 'package:flutter/material.dart';

class PesanPetaniPage extends StatelessWidget {
  const PesanPetaniPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesan ke Petani/UMKM'),
         titleTextStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF42A5F5),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Pesan ke Petani/UMKM Page - Coming Soon'),
      ),
    );
  }
}