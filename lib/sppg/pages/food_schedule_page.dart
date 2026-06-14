import 'package:flutter/material.dart';
import 'package:mbg_app/database/database_helper.dart';

import 'package:mbg_app/models/menu_model.dart';
import 'package:mbg_app/sppg/add_menu_page.dart';
import 'package:mbg_app/sppg/edit_menu_page.dart';


class FoodSchedulePage extends StatefulWidget {
  const FoodSchedulePage({super.key});

  @override
  State<FoodSchedulePage> createState() => _FoodSchedulePageState();
}

class _FoodSchedulePageState extends State<FoodSchedulePage> {
  final DatabaseHelper db = DatabaseHelper();
  List<Menu> menus = [];
  String selectedMonth = 'Mei 2026';
  DateTime currentDate = DateTime(2026, 5, 1);
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final loadedMenus = await db.getMenusByMonth(currentDate.year, currentDate.month);
      setState(() {
        menus = loadedMenus;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error loading menus: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading data: $e')),
      );
    }
  }

  Future<void> _addMenu() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddMenuPage()),
    );
    if (result == true) {
      _loadData();
    }
  }

  Future<void> _editMenu(Menu menu) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditMenuPage(menu: menu),
      ),
    );
    if (result == true) {
      _loadData();
    }
  }

  void _changeMonth(int delta) {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month + delta);
      selectedMonth = '${_getMonthName(currentDate.month)} ${currentDate.year}';
    });
    _loadData();
  }

  String _getMonthName(int month) {
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return months[month - 1];
  }

  String _formatDate(String date) {
    List<String> parts = date.split('-');
    if (parts.length == 3) {
      return '${parts[2]}/${parts[1]}/${parts[0]}';
    }
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu Makanan 1x Sehari',
        ),
         titleTextStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFFE65100),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addMenu,
            tooltip: 'Tambah Menu',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildMonthSelector(),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : menus.isEmpty
                    ? const Center(child: Text('Tidak ada data menu untuk bulan ini'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: menus.length,
                        itemBuilder: (context, index) {
                          final menu = menus[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: InkWell(
                              onTap: () => _editMenu(menu),
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${menu.hari}, ${_formatDate(menu.tanggal)}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFE65100),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                '${menu.hari}, ${_formatDate(menu.tanggal)}',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE65100).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: const Icon(
                                            Icons.edit,
                                            size: 20,
                                            color: Color(0xFFE65100),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    const Divider(),
                                    const SizedBox(height: 8),
                                    _buildNutritionSummary(menu),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => _changeMonth(-1),
          ),
          Text(
            selectedMonth,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => _changeMonth(1),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionSummary(Menu menu) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildNutritionChip('${menu.kalori.round()} kkal', Colors.orange),
        _buildNutritionChip('${menu.protein.round()}g Protein', Colors.green),
        _buildNutritionChip('${menu.karbohidrat.round()}g Karbo', Colors.blue),
        _buildNutritionChip('${menu.lemak.round()}g Lemak', Colors.red),
      ],
    );
  }

  Widget _buildNutritionChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}