import 'package:flutter/material.dart';

class FinanceReportPage extends StatelessWidget {
  const FinanceReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Keuangan'),
        backgroundColor: const Color(0xFFC2185B),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Text('Halaman Laporan Keuangan SPPG'),
      ),
    );
  }
}