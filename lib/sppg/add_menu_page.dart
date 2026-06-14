import 'package:flutter/material.dart';
import 'package:mbg_app/models/menu_model.dart';
import '../database/database_helper.dart';


class AddMenuPage extends StatefulWidget {
  const AddMenuPage({super.key});

  @override
  State<AddMenuPage> createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  final DatabaseHelper db = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();
  
  final _tanggalController = TextEditingController();
  final _hariController = TextEditingController();
  final _menuPagiController = TextEditingController();
  final _menuSiangController = TextEditingController();
  final _menuMalamController = TextEditingController();
  final _kaloriController = TextEditingController();
  final _proteinController = TextEditingController();
  final _karbohidratController = TextEditingController();
  final _lemakController = TextEditingController();

  Future<void> _saveMenu() async {
    if (_formKey.currentState!.validate()) {
      final newMenu = Menu(
        tanggal: _tanggalController.text,
        hari: _hariController.text,
        menuPagi: _menuPagiController.text,
        menuSiang: _menuSiangController.text,
        menuMalam: _menuMalamController.text,
        kalori: double.parse(_kaloriController.text),
        protein: double.parse(_proteinController.text),
        karbohidrat: double.parse(_karbohidratController.text),
        lemak: double.parse(_lemakController.text),
      );
      
      await db.insertMenu(newMenu);
      Navigator.pop(context, true);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Menu berhasil ditambahkan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Menu Baru'),
        titleTextStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFFE65100),
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _tanggalController,
              decoration: const InputDecoration(labelText: 'Tanggal (YYYY-MM-DD)'),
              validator: (value) => value!.isEmpty ? 'Tanggal harus diisi' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _hariController,
              decoration: const InputDecoration(labelText: 'Hari'),
              validator: (value) => value!.isEmpty ? 'Hari harus diisi' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _menuPagiController,
              decoration: const InputDecoration(labelText: 'Menu Pagi'),
              validator: (value) => value!.isEmpty ? 'Menu pagi harus diisi' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _menuSiangController,
              decoration: const InputDecoration(labelText: 'Menu Siang'),
              validator: (value) => value!.isEmpty ? 'Menu siang harus diisi' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _menuMalamController,
              decoration: const InputDecoration(labelText: 'Menu Malam'),
              validator: (value) => value!.isEmpty ? 'Menu malam harus diisi' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _kaloriController,
              decoration: const InputDecoration(labelText: 'Total Kalori'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Kalori harus diisi' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _proteinController,
              decoration: const InputDecoration(labelText: 'Protein (gram)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _karbohidratController,
              decoration: const InputDecoration(labelText: 'Karbohidrat (gram)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _lemakController,
              decoration: const InputDecoration(labelText: 'Lemak (gram)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveMenu,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE65100),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Simpan Menu'),
            ),
          ],
        ),
      ),
    );
  }
}