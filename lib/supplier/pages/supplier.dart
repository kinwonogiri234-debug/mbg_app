import 'package:flutter/material.dart';
import 'package:mbg_app/main.dart';

import 'data_order_page.dart';
import 'stok_barang_page.dart';
import 'jadwal_page.dart';
import 'laporan_page.dart';
import 'data_sppg_page.dart';
import 'data_petani_page.dart';
import 'pesan_petani_page.dart';

class SupplierDashboard extends StatelessWidget {
  final User user;
  const SupplierDashboard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Supplier'),
        titleTextStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF42A5F5),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE8F4FD), Color(0xFFB3E0FC)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF42A5F5).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.check_box_outline_blank_outlined, 
                          size: 50, 
                          color: Color(0xFF42A5F5)
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Selamat Datang, Supplier',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Anda login sebagai Supplier',
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Menu Supplier',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.1,
                  children: [
                    _buildMenuCard(
                      Icons.shopping_cart, 
                      'Data Order', 
                      'Permintaan dari SPPG', 
                      Colors.blue,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DataOrderPage()),
                        );
                      }
                    ),
                    _buildMenuCard(
                      Icons.inventory, 
                      'Stok Barang', 
                      'Stock bahan makanan', 
                      Colors.green,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const StokBarangPage()),
                        );
                      }
                    ),
                    _buildMenuCard(
                      Icons.schedule, 
                      'Jadwal', 
                      'Jam Pengiriman', 
                      Colors.orange,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const JadwalPage()),
                        );
                      }
                    ),
                    _buildMenuCard(
                      Icons.receipt_long, 
                      'Laporan', 
                      'Laporan Keuangan', 
                      Colors.purple,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LaporanPage()),
                        );
                      }
                    ),
                    _buildMenuCard(
                      Icons.people, 
                      'Data SPPG', 
                      'Data SPPG yang dikirim', 
                      Colors.red,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DataSPPGPage()),
                        );
                      }
                    ),
                    _buildMenuCard(
                      Icons.agriculture, 
                      'Data Petani/UMKM', 
                      'Data UMKM yang supply bahan', 
                      Colors.brown,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DataPetaniPage()),
                        );
                      }
                    ),
                    _buildMenuCard(
                      Icons.message, 
                      'Pesan', 
                      'Pesan ke petani/UMKM', 
                      Colors.teal,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PesanPetaniPage()),
                        );
                      }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(IconData icon, String title, String subtitle, Color color, VoidCallback onTap) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 45, color: color),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(fontSize: 10), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}