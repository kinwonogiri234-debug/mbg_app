import 'package:flutter/material.dart';

class FoodSchedulePage extends StatelessWidget {
  const FoodSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Makanan'),
        backgroundColor: const Color(0xFFE65100),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Text('Halaman Jadwal Menu Makanan'),
      ),
    );
  }
}