import 'package:flutter/material.dart';

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
                    Icons.flutter_dash,
                    size: 60,
                    color: Color(0xFF42A5F5),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Selamat Datang di',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF1976D2),
                  ),
                ),
                const Text(
                  'MBG Aplikasi',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D47A1),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Solusi terbaik untuk kebutuhan Anda',
                  style: TextStyle(
                    fontSize: 9,
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
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 55,
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
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
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
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                        letterSpacing: 2,
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
                          height: 55,
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
                                fontSize: 18,
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
                        // Header
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF42A5F5), Color(0xFF0D47A1)],
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.info_outline, color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Info Login Demo',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Body - Grid 2 Kolom
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1.2,
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
                                          Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: Colors.blue.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: const Icon(Icons.school, size: 18, color: Colors.blue),
                                          ),
                                          const SizedBox(width: 8),
                                          const Text(
                                            'SPPG',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.person_outline, size: 12, color: Color(0xFF546E7A)),
                                          const SizedBox(width: 4),
                                          const Text(':', style: TextStyle(fontSize: 10, color: Color(0xFF546E7A))),
                                          const SizedBox(width: 4),
                                          Text('sppg', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.blue)),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(Icons.lock_outline, size: 12, color: Color(0xFF546E7A)),
                                          const SizedBox(width: 4),
                                          const Text(':', style: TextStyle(fontSize: 10, color: Color(0xFF546E7A))),
                                          const SizedBox(width: 4),
                                          Text('sppg', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.blue)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              
                              // Card Sekolah
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.green.withOpacity(0.3),
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
                                          Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: Colors.green.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: const Icon(Icons.business, size: 18, color: Colors.green),
                                          ),
                                          const SizedBox(width: 8),
                                          const Text('Sekolah', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green)),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.person_outline, size: 12, color: Color(0xFF546E7A)),
                                          const SizedBox(width: 4),
                                          const Text(':', style: TextStyle(fontSize: 10, color: Color(0xFF546E7A))),
                                          const SizedBox(width: 4),
                                          const Text('sekolah', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.green)),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(Icons.lock_outline, size: 12, color: Color(0xFF546E7A)),
                                          const SizedBox(width: 4),
                                          const Text(':', style: TextStyle(fontSize: 10, color: Color(0xFF546E7A))),
                                          const SizedBox(width: 4),
                                          const Text('sekolah', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.green)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              
                              // Card Supplier
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.orange.withOpacity(0.3),
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
                                          Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: Colors.orange.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: const Icon(Icons.local_shipping, size: 18, color: Colors.orange),
                                          ),
                                          const SizedBox(width: 8),
                                          const Text('Supplier', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange)),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.person_outline, size: 12, color: Color(0xFF546E7A)),
                                          const SizedBox(width: 4),
                                          const Text(':', style: TextStyle(fontSize: 10, color: Color(0xFF546E7A))),
                                          const SizedBox(width: 4),
                                          const Text('suplayer', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.orange)),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(Icons.lock_outline, size: 12, color: Color(0xFF546E7A)),
                                          const SizedBox(width: 4),
                                          const Text(':', style: TextStyle(fontSize: 10, color: Color(0xFF546E7A))),
                                          const SizedBox(width: 4),
                                          const Text('suplayer', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.orange)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              
                              // Card Admin
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.purple.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.purple.withOpacity(0.3),
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
                                          Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: Colors.purple.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: const Icon(Icons.admin_panel_settings, size: 18, color: Colors.purple),
                                          ),
                                          const SizedBox(width: 8),
                                          const Text('Admin', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.purple)),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.person_outline, size: 12, color: Color(0xFF546E7A)),
                                          const SizedBox(width: 4),
                                          const Text(':', style: TextStyle(fontSize: 10, color: Color(0xFF546E7A))),
                                          const SizedBox(width: 4),
                                          const Text('admin', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.purple)),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(Icons.lock_outline, size: 12, color: Color(0xFF546E7A)),
                                          const SizedBox(width: 4),
                                          const Text(':', style: TextStyle(fontSize: 10, color: Color(0xFF546E7A))),
                                          const SizedBox(width: 4),
                                          const Text('admin', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.purple)),
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

// Dashboard SPPG
class SPPGDashboard extends StatelessWidget {
  final User user;
  const SPPGDashboard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard SPPG'),
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF42A5F5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.school, size: 35, color: Color(0xFF42A5F5)),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user.name,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Text(
                    'Role: ${user.role}',
                    style: const TextStyle(color: Colors.white70, fontSize: 9),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Data Sekolah'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.class_),
              title: const Text('Manajemen Distribusi'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.assessment),
              title: const Text('Laporan'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
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
                      const Icon(Icons.handshake_rounded, size: 50, color: Color(0xFF42A5F5)),
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
                'Menu SPPG',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildMenuCard(Icons.people, 'Data Peserta', 'Kelola data peserta', Colors.blue),
                    _buildMenuCard(Icons.class_, 'Kelas Pelatihan', 'Atur jadwal kelas', Colors.green),
                    _buildMenuCard(Icons.assessment, 'Evaluasi', 'Lihat hasil evaluasi', Colors.orange),
                    _buildMenuCard(Icons.calendar_today, 'Jadwal', 'Jadwal pelatihan', Colors.purple),
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
                      const Icon(Icons.health_and_safety, size: 50, color: Color(0xFF42A5F5)),
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
                'Menu Sekolah',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildMenuCard(Icons.verified_user_outlined, 'Data Siswa', 'Lihat data siswa', Colors.blue),
                    _buildMenuCard(Icons.note_alt, 'Nilai', 'Input dan lihat nilai', Colors.green),
                    _buildMenuCard(Icons.attach_money, 'Pembayaran', 'Info pembayaran', Colors.orange),
                    _buildMenuCard(Icons.schedule, 'Jadwal Ujian', 'Lihat jadwal ujian', Colors.purple),
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
                'Menu Supplier',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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