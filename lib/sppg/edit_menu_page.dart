import 'package:flutter/material.dart';
import 'package:mbg_app/database/database_helper.dart';
import 'package:mbg_app/models/menu_model.dart';


class EditMenuPage extends StatefulWidget {
  final Menu menu;
  const EditMenuPage({super.key, required this.menu});

  @override
  State<EditMenuPage> createState() => _EditMenuPageState();
}

class _EditMenuPageState extends State<EditMenuPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _menuPagiController;
  late TextEditingController _menuSiangController;
  late TextEditingController _menuMalamController;
  late TextEditingController _kaloriController;
  late TextEditingController _proteinController;
  late TextEditingController _karbohidratController;
  late TextEditingController _lemakController;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _menuPagiController = TextEditingController(text: widget.menu.menuPagi);
    _menuSiangController = TextEditingController(text: widget.menu.menuSiang);
    _menuMalamController = TextEditingController(text: widget.menu.menuMalam);
    _kaloriController =
        TextEditingController(text: widget.menu.kalori.toString());
    _proteinController =
        TextEditingController(text: widget.menu.protein.toString());
    _karbohidratController =
        TextEditingController(text: widget.menu.karbohidrat.toString());
    _lemakController =
        TextEditingController(text: widget.menu.lemak.toString());
  }

  @override
  void dispose() {
    _menuPagiController.dispose();
    _menuSiangController.dispose();
    _menuMalamController.dispose();
    _kaloriController.dispose();
    _proteinController.dispose();
    _karbohidratController.dispose();
    _lemakController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      final updatedMenu = Menu(
        id: widget.menu.id,
        tanggal: widget.menu.tanggal,
        hari: widget.menu.hari,
        menuPagi: _menuPagiController.text,
        menuSiang: _menuSiangController.text,
        menuMalam: _menuMalamController.text,
        kalori: double.parse(_kaloriController.text),
        protein: double.parse(_proteinController.text),
        karbohidrat: double.parse(_karbohidratController.text),
        lemak: double.parse(_lemakController.text),
      );

      await _dbHelper.updateMenu(updatedMenu);
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Menu berhasil diupdate')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Menu - ${widget.menu.tanggal}'),
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
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _menuPagiController,
                      decoration: const InputDecoration(
                        labelText: 'Menu Pagi',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.brightness_7),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Menu pagi tidak boleh kosong' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _menuSiangController,
                      decoration: const InputDecoration(
                        labelText: 'Menu Siang',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.brightness_5),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Menu siang tidak boleh kosong' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _menuMalamController,
                      decoration: const InputDecoration(
                        labelText: 'Menu Malam',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.nights_stay),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Menu malam tidak boleh kosong' : null,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _kaloriController,
                      decoration: const InputDecoration(
                        labelText: 'Kalori (kcal)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.local_fire_department),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'Kalori tidak boleh kosong' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _proteinController,
                      decoration: const InputDecoration(
                        labelText: 'Protein (g)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.fitness_center),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'Protein tidak boleh kosong' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _karbohidratController,
                      decoration: const InputDecoration(
                        labelText: 'Karbohidrat (g)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.grain),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'Karbohidrat tidak boleh kosong' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _lemakController,
                      decoration: const InputDecoration(
                        labelText: 'Lemak (g)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.opacity),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'Lemak tidak boleh kosong' : null,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE65100),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}