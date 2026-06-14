import 'package:flutter/material.dart';
import 'package:mbg_app/sppg/pages/finance_report_page.dart';
import 'package:mbg_app/sppg/pages/food_schedule_page.dart';
import 'package:mbg_app/sppg/pages/monitoring_page.dart';
import 'package:mbg_app/sppg/pages/report_page.dart';
import 'package:mbg_app/sppg/pages/school_menu_page.dart';
import 'package:mbg_app/sppg/pages/stock_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MBG App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

// Model untuk User
class User {
  final String username;
  final String role;
  final String name;

  User({
    required this.username,
    required this.role,
    required this.name,
  });
}

// Halaman Utama (Home)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE8F4FD),
              Color(0xFFB3E0FC),
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.add_photo_alternate,
                    size: 60,
                    color: Color(0xFF42A5F5),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Selamat Datang di',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF1976D2),
                  ),
                ),
                const Text(
                  'Distribusi App',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D47A1),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Solusi terbaik untuk Pemenuhan GIZI',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF546E7A),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),

                SizedBox(
                  width: double.infinity,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF42A5F5),
                      foregroundColor: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: Colors.blue.withOpacity(0.5),
                    ),
                    child: const Text(
                      'Masuk ke Akun',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 35,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF42A5F5),
                      side: const BorderSide(color: Color(0xFF42A5F5), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  child: const Text(
                    'Daftar Baru',
                    style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF1976D2),
                  ),
                  ),
                    
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Halaman Login
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  // Data login valid - DIPINDAHKAN KE ATAS (sebelum digunakan)
  final Map<String, Map<String, String>> _validCredentials = {
    'sppg': {'username': 'sppg', 'password': 'sppg', 'role': 'SPPG', 'name': 'Satuan Pelayanan Pemenuhan Gizi'},
    'sekolah': {'username': 'sekolah', 'password': 'sekolah', 'role': 'Sekolah', 'name': 'Satuan pendidikan penerima manfaat'},
    'suplayer': {'username': 'suplayer', 'password': 'suplayer', 'role': 'Supplier', 'name': 'supplier mitra dapur'},
    'admin': {'username': 'admin', 'password': 'admin', 'role': 'Admin', 'name': 'Admin MBG'},
  };

  void _handleLogin() {
    String username = _usernameController.text.toLowerCase().trim();
    String password = _passwordController.text;

    // Validasi input kosong
    if (username.isEmpty || password.isEmpty) {
      _showSnackBar('Harap isi username dan password!', Colors.orange);
      return;
    }

    // Cari user berdasarkan username
    String? foundRole;
    Map<String, String>? userData;

    for (var entry in _validCredentials.entries) {
      if (entry.value['username'] == username) {
        foundRole = entry.key;
        userData = entry.value;
        break;
      }
    }

    // Validasi login
    if (userData != null && userData['password'] == password) {
      // Login berhasil
      User user = User(
        username: username,
        role: userData['role']!,
        name: userData['name']!,
      );
      
      _showSnackBar('Login berhasil! Selamat datang, ${userData['name']}', Colors.green);
      
      // Navigasi ke dashboard sesuai role
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => _getDashboardPage(user),
        ),
      );
    } else {
      _showSnackBar('Username atau password salah!', Colors.red);
    }
  }

  Widget _getDashboardPage(User user) {
    switch (user.role) {
      case 'SPPG':
        return SPPGDashboard(user: user);
      case 'Sekolah':
        return SekolahDashboard(user: user);
      case 'Supplier':
        return SupplierDashboard(user: user);
      case 'Admin':
        return AdminDashboard(user: user);
      default:
        return const HomePage();
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE3F2FD),
              Color(0xFFBBDEFB),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF1976D2),
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 134, 29, 2),
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'Masuk ke akun MBG Anda',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF546E7A),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Form Login
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: const TextStyle(
                              color: Color(0xFF42A5F5),
                              fontWeight: FontWeight.w500,
                            ),
                            hintText: 'Masukkan username Anda',
                            hintStyle: TextStyle(
                              color: Colors.grey.withOpacity(0.7),
                            ),
                            prefixIcon: const Icon(
                              Icons.person_outline,
                              color: Color(0xFF42A5F5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Color(0xFF42A5F5),
                                width: 2,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            color: Color(0xFF0D47A1),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              color: Color(0xFF42A5F5),
                              fontWeight: FontWeight.w500,
                            ),
                            hintText: 'Masukkan password Anda',
                            hintStyle: TextStyle(
                              color: Colors.grey.withOpacity(0.7),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Color(0xFF42A5F5),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color(0xFF42A5F5),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Color(0xFF42A5F5),
                                width: 2,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            color: Color(0xFF0D47A1),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value!;
                                    });
                                  },
                                  activeColor: const Color(0xFF42A5F5),
                                  checkColor: Colors.white,
                                ),
                                const Text(
                                  'Ingat Saya',
                                  style: TextStyle(
                                    color: Color(0xFF546E7A),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Lupa Password?',
                                style: TextStyle(
                                  color: Color(0xFF42A5F5),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 35,
                          child: ElevatedButton(
                            onPressed: _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF42A5F5),
                              foregroundColor: Colors.white,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              shadowColor: Colors.blue.withOpacity(0.5),
                            ),
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Info Login Demo Card - Grid 2 Kolom (Ukuran Proporsional)
                  Container(
                    margin: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.1),
                          blurRadius: 15,
                          spreadRadius: 2,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        // Body - Grid 2 Kolom
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 1,
                            crossAxisSpacing: 6,
                            mainAxisSpacing: 5,
                            childAspectRatio: 2.5,
                            children: [
                              // Card SPPG
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.blue.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Username = sppg | Password  =  sppg',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                           const Text(
                                            'Username = sekolah | Password  =  sekolah',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                           const Text(
                                            'Username = suplayer | Password  =  suplayer',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Text(
                                            'Username = admin | Password  =  admin',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Belum punya akun? ',
                        style: TextStyle(color: Color(0xFF546E7A)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Daftar Sekarang',
                          style: TextStyle(
                            color: Color(0xFF42A5F5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logobatas.png',
                      height: 50,
                      width: 50,
                      errorBuilder: (context, error, stackTrace) {
                        // Tampilkan icon default jika image tidak ditemukan
                        return const Icon(Icons.image_not_supported, size: 24);
                      },
                      ),
                    ],
                  ),
                
                
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

// Dashboard SPPG - MBG (Makan Bergizi Gratis)
class SPPGDashboard extends StatelessWidget {
  final User user;
  const SPPGDashboard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SPPG Dashboard - MBG'),
        titleTextStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF2E7D32),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.restaurant, size: 35, color: Color(0xFF2E7D32)),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user.name,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    'Role: ${user.role}',
                    style: const TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.school, 'Data Sekolah', () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (_) => const SchoolMenuPage())
              ); //Navigator.pop(context);
            }),
            _buildDrawerItem(Icons.menu_book, 'Menu Makanan', () {
              //Navigator.pop(context);
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const FoodSchedulePage()),
              );
            }),

            _buildDrawerItem(Icons.receipt, 'Laporan Penerimaan', () {
              //Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReportPage()),
              );
            }),

            _buildDrawerItem(Icons.inventory, 'Stok Bahan Makanan', () {
              //Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StockPage()),
                );
            }),

            _buildDrawerItem(Icons.account_balance_wallet, 'Laporan Keuangan', () {
              //Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FinanceReportPage()),
                );
            }),


            _buildDrawerItem(Icons.mobile_friendly, 'Monitoring', () {
              //Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MonitoringPage()),
              );

            }),

            const Divider(),
            _buildDrawerItem(Icons.settings, 'Pengaturan', () {
              Navigator.pop(context);
            }),

          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF1F8E9), Color(0xFFC8E6C9)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeCard(),
              const SizedBox(height: 20),
              const Text(
                'Menu Utama SPPG',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
              ),
              const SizedBox(height: 0),
              const Text(
                'Kelola Pemenuhan Gizi Makanan Bergizi Gratis',
                style: TextStyle(fontSize: 9, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.0,
                children: [
                  _buildMenuCard(
                    icon: Icons.school,
                    title: 'Sekolah',
                    subtitle: 'Data & area sekolah',
                    color: const Color(0xFF1565C0),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SchoolMenuPage())),
                  ),
                  _buildMenuCard(
                    icon: Icons.menu_book,
                    title: 'Menu Makanan',
                    subtitle: 'Jadwal menu harian',
                    color: const Color(0xFFE65100),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FoodSchedulePage())),
                  ),
                  _buildMenuCard(
                    icon: Icons.receipt,
                    title: 'Laporan',
                    subtitle: 'Penerimaan & return',
                    color: const Color(0xFF6A1B9A),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportPage())),
                  ),
                  _buildMenuCard(
                    icon: Icons.inventory,
                    title: 'Stok Bahan',
                    subtitle: 'Prediksi stok hari',
                    color: const Color(0xFF2E7D32),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StockPage())),
                  ),
                  _buildMenuCard(
                    icon: Icons.account_balance_wallet,
                    title: 'Laporan Keuangan',
                    subtitle: 'Keuangan SPPG',
                    color: const Color(0xFFC2185B),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FinanceReportPage())),
                  ),
                  _buildMenuCard(
                    icon: Icons.trending_up,
                    title: 'Monitoring',
                    subtitle: 'Dashboard & evaluasi',
                    color: const Color(0xFFF57C00),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MonitoringPage())),
                  ),
                ],),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF2E7D32)),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32).withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.restaurant, size: 45, color: Color(0xFF2E7D32)),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Datang, ${user.name}',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Anda login sebagai ${user.role} • SPPG',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E7D32).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Makan Bergizi Gratis',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, size: 45, color: color),
              ),
              const SizedBox(height: 12),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  // Navigation Methods
  void _navigateToSchoolMenu(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SchoolMenuPage()));
  }

  void _navigateToFoodMenu(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => FoodSchedulePage()));
  }

  void _navigateToReport(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ReportPage()));
  }

  void _navigateToStock(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => StockPage()));
  }

  void _navigateToFinance(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => FinanceReportPage()));
  }

  void _navigateToMonitoring(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => MonitoringPage()));
  }
}


// Additional Model for Financial Data
class FinancialData {
  final List<SupplierDebt> supplierDebts;
  final List<AgentDebt> agentDebts;
  final List<EmployeeSalary> employeeSalaries;
  final List<CarRental> carRentals;
  final List<Accommodation> accommodations;
  final List<OtherExpense> otherExpenses;

  FinancialData({
    required this.supplierDebts,
    required this.agentDebts,
    required this.employeeSalaries,
    required this.carRentals,
    required this.accommodations,
    required this.otherExpenses,
  });

  double get totalExpenses {
    double total = 0;
    total += supplierDebts.fold(0, (sum, item) => sum + item.amount);
    total += agentDebts.fold(0, (sum, item) => sum + item.amount);
    total += employeeSalaries.fold(0, (sum, item) => sum + item.amount);
    total += carRentals.fold(0, (sum, item) => sum + item.rentalCost);  // ← fixed: 'rentalCost'
    total += accommodations.fold(0, (sum, item) => sum + item.cost);     // ← fixed: 'cost'
    total += otherExpenses.fold(0, (sum, item) => sum + item.amount);    // ← correct
    return total;
  }
}

class SupplierDebt {
  final String supplierName;
  final double amount;
  final DateTime dueDate;
  SupplierDebt({required this.supplierName, required this.amount, required this.dueDate});
}

class AgentDebt {
  final String agentName;
  final double amount;
  final DateTime dueDate;
  AgentDebt({required this.agentName, required this.amount, required this.dueDate});
}

class EmployeeSalary {
  final String employeeName;
  final double amount;
  final DateTime payDate;
  EmployeeSalary({required this.employeeName, required this.amount, required this.payDate});
}

class CarRental {
  final String vehicleNumber;
  final double rentalCost;
  final DateTime rentalPeriod;
  CarRental({required this.vehicleNumber, required this.rentalCost, required this.rentalPeriod});
}

class Accommodation {
  final String location;
  final double cost;
  
  final DateTime stayPeriod;
  Accommodation({required this.location, required this.cost, required this.stayPeriod});
}

class OtherExpense {
  final String description;
  final double amount;
  final DateTime date;
  OtherExpense({required this.description, required this.amount, required this.date});
}

// Dashboard Sekolah
class SekolahDashboard extends StatelessWidget {
  final User user;
  const SekolahDashboard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    const icons = Icons;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Sekolah'),
         titleTextStyle: const TextStyle(
          fontSize: 12,
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
                  child: Column(
                    children: [
                      const Icon(Icons.people, size: 50, color: Color(0xFF42A5F5)),
                      const SizedBox(height: 10),
                      Text(
                        'Selamat Datang, ${user.name}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text('Anda login sebagai ${user.role}'),
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
                  children: [
                    _buildMenuCard(Icons.verified_user_outlined, 'Data Siswa', 'Data siswa yang hadir', Colors.blue),
                    _buildMenuCard(Icons.note_alt, 'Dokomentasi', 'Foto Kegiatan', Colors.green),
                    _buildMenuCard(Icons.arrow_circle_down, 'Laporan', 'Laporan Kegiatan MBG', Colors.orange),
                    _buildMenuCard(Icons.schedule, 'Order', 'Order makanan', Colors.purple),
                    _buildMenuCard(Icons.calendar_today, 'Jadwal', 'Jadwal makanan', Colors.purple),
                    _buildMenuCard(Icons.arrow_back, 'Struktur', 'Penanggung Jawab ', Colors.purple),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(IconData icon, String title, String subtitle, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: color),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(subtitle, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

// Dashboard Supplier
class SupplierDashboard extends StatelessWidget {
  final User user;
  const SupplierDashboard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Supplier'),
        titleTextStyle: const TextStyle(
          fontSize: 12,
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
                  child: Column(
                    children: [
                      const Icon(Icons.check_box_outline_blank_outlined, size: 50, color: Color(0xFF42A5F5)),
                      const SizedBox(height: 10),
                      Text(
                        'Selamat Datang, ${user.name}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text('Anda login sebagai ${user.role}'),
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
                  children: [
                    _buildMenuCard(Icons.inventory, 'Stok Barang', 'Kelola stok barang', Colors.blue),
                    _buildMenuCard(Icons.shopping_cart, 'Pesanan', 'Lihat pesanan masuk', Colors.green),
                    _buildMenuCard(Icons.local_shipping, 'Pengiriman', 'Status pengiriman', Colors.orange),
                    _buildMenuCard(Icons.receipt, 'Faktur', 'Lihat faktur', Colors.purple),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(IconData icon, String title, String subtitle, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: color),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(subtitle, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

// Dashboard Admin
class AdminDashboard extends StatelessWidget {
  final User user;
  const AdminDashboard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Admin'),
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
                  child: Column(
                    children: [
                      const Icon(Icons.handyman_outlined, size: 50, color: Color(0xFF42A5F5)),
                      const SizedBox(height: 10),
                      Text(
                        'Selamat Datang, ${user.name}',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text('Anda login sebagai ${user.role}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Menu Admin',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildMenuCard(Icons.people, 'Kelola User', 'Tambah/edit user', Colors.blue),
                    _buildMenuCard(Icons.settings, 'Pengaturan', 'Pengaturan sistem', Colors.green),
                    _buildMenuCard(Icons.report, 'Laporan', 'Lihat semua laporan', Colors.orange),
                    _buildMenuCard(Icons.security, 'Keamanan', 'Pengaturan keamanan', Colors.purple),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(IconData icon, String title, String subtitle, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: color),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(subtitle, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}