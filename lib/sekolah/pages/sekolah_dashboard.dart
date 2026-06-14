import 'package:flutter/material.dart';
import 'package:mbg_app/main.dart';


class SekolahDashboard extends StatelessWidget {
  final User user;
  const SekolahDashboard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Sekolah'),
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
                          Icons.school, 
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
                              'Selamat Datang di Sekolah',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Satuan Pendidikan Penerima Manfaat',
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
                'Menu Sekolah',
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
                      Icons.restaurant,
                      'Data Makanan',
                      'Informasi menu makanan',
                      Colors.blue,
                      () {
                        _showComingSoon(context);
                      },
                    ),
                    _buildMenuCard(
                      Icons.people,
                      'Data Siswa',
                      'Kelola data siswa',
                      Colors.green,
                      () {
                        _showComingSoon(context);
                      },
                    ),
                    _buildMenuCard(
                      Icons.receipt,
                      'Konfirmasi Terima',
                      'Konfirmasi penerimaan',
                      Colors.orange,
                      () {
                        _showComingSoon(context);
                      },
                    ),
                    _buildMenuCard(
                      Icons.history,
                      'Riwayat',
                      'Riwayat pengiriman',
                      Colors.purple,
                      () {
                        _showComingSoon(context);
                      },
                    ),
                    _buildMenuCard(
                      Icons.assessment,
                      'Laporan',
                      'Laporan konsumsi',
                      Colors.red,
                      () {
                        _showComingSoon(context);
                      },
                    ),
                    _buildMenuCard(
                      Icons.message,
                      'Pesan',
                      'Pesan ke SPPG',
                      Colors.teal,
                      () {
                        _showComingSoon(context);
                      },
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

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur sedang dalam pengembangan'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}