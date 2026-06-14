import 'package:mbg_app/models/menu_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'food_menu.db');
    
    return await openDatabase(
      path,
      version: 2, // Upgrade version untuk menambah data
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Tabel menu
    await db.execute('''
      CREATE TABLE menus(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tanggal TEXT UNIQUE NOT NULL,
        hari TEXT NOT NULL,
        menu TEXT NOT NULL,
        kalori REAL NOT NULL,
        protein REAL NOT NULL,
        karbohidrat REAL NOT NULL,
        lemak REAL NOT NULL,
        status TEXT DEFAULT 'active',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Insert data Mei dan Juni 2026
    await _insertAllData(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Hapus data lama
      await db.delete('menus');
      // Insert data baru
      await _insertAllData(db);
    }
  }

  Future<void> _insertAllData(Database db) async {
    // Data menu untuk Mei 2026 (1-31 Mei)
    await _insertMayData(db);
    
    // Data menu untuk Juni 2026 (1-13 Juni)
    await _insertJuneData(db);
  }

  Future<void> _insertMayData(Database db) async {
    List<String> menuList = [
      'Nasi + Ayam Goreng + Sayur Bayam + Tahu',
      'Nasi + Ikan Bakar + Tumis Kangkung + Tempe',
      'Nasi + Rendang + Sayur Nangka + Telur',
      'Nasi + Pepes Ikan + Lalapan + Tahu',
      'Soto Ayam + Tahu Tempe + Kerupuk',
      'Nasi + Telur Dadar + Sayur Asem + Tempe',
      'Sup Jagung + Ayam Panggang + Kentang',
      'Nasi Uduk + Empal + Sambal + Tahu',
      'Mie Ayam + Pangsit + Bakso',
      'Nasi + Gulai Kambing + Sayur Kacang',
      'Bubur Ayam + Telur Rebus + Cakwe',
      'Nasi + Bebek Goreng + Sambal + Tahu',
      'Capcay + Tahu Goreng + Ayam',
      'Nasi Kuning + Ayam Suwir + Telur',
      'Nasi + Pepes Tahu + Sayur Bayam',
      'Nasi + Ayam Bakar + Sambal Terasi',
      'Nasi + Lele Goreng + Lalapan',
      'Nasi + Tongkol Suwir + Sayur Nangka',
      'Nasi + Ati Ampela + Sayur Bening',
      'Nasi + Opor Ayam + Sayur Labu',
      'Nasi + Semur Jengkol + Tahu',
      'Nasi + Dendeng Balado + Sayur Daun Singkong',
      'Nasi + Cumi Hitam + Sayur Kangkung',
      'Nasi + Udang Saus Padang + Tahu',
      'Nasi + Kepiting Saus Tiram + Sayur Asem',
      'Nasi + Gurame Bakar + Sambal Dabu-dabu',
      'Nasi + Sate Ayam + Tahu Tempe',
      'Nasi + Gado-gado + Lontong',
      'Nasi + Rawon + Telur Asin',
      'Nasi + Sop Buntut + Kentang Wortel',
      'Nasi + Ikan Patin Bakar + Lalapan',
    ];

    List<String> hariList = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    
    for (int i = 1; i <= 31; i++) {
      DateTime date = DateTime(2026, 5, i);
      String hari = hariList[date.weekday - 1];
      
      // Menu unik per tanggal
      String menu = menuList[(i - 1) % menuList.length];
      
      // Nilai gizi yang bervariasi per hari
      double kalori = 400 + (i * 3.5);
      double protein = 18 + (i % 20);
      double karbohidrat = 45 + (i % 25);
      double lemak = 8 + (i % 15);
      
      await db.insert('menus', {
        'tanggal': '2026-05-${i.toString().padLeft(2, '0')}',
        'hari': hari,
        'menu': menu,
        'kalori': kalori,
        'protein': protein,
        'karbohidrat': karbohidrat,
        'lemak': lemak,
        'status': 'active',
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<void> _insertJuneData(Database db) async {
    List<String> menuList = [
      'Nasi + Ayam Goreng Mentega + Sayur Brokoli',
      'Nasi + Ikan Salmon Bakar + Tumis Asparagus',
      'Nasi + Daging Teriyaki + Sayur Pakcoy',
      'Nasi + Tahu Saus Tiram + Sayur Pokcoy',
      'Nasi + Udang Goreng Tepung + Sayur Kol',
      'Nasi + Cumi Saus Padang + Sayur Nangka',
      'Nasi + Kepiting Saus Telur Asin + Sayur Wortel',
      'Nasi + Sosis Ayam + Sayur Buncis',
      'Nasi + Bakso Sapi + Tahu Gejrot',
      'Nasi + Ikan Gurame Saus Asam Manis + Sayur Capcay',
      'Nasi + Telur Balado + Terong Goreng',
      'Nasi + Paru Goreng + Sambal Matah',
      'Nasi + Usus Goreng + Tahu Petis',
    ];

    List<String> hariList = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    
    for (int i = 1; i <= 13; i++) {
      DateTime date = DateTime(2026, 6, i);
      String hari = hariList[date.weekday - 1];
      
      String menu = menuList[(i - 1) % menuList.length];
      
      double kalori = 420 + (i * 4);
      double protein = 20 + (i % 18);
      double karbohidrat = 48 + (i % 22);
      double lemak = 10 + (i % 12);
      
      await db.insert('menus', {
        'tanggal': '2026-06-${i.toString().padLeft(2, '0')}',
        'hari': hari,
        'menu': menu,
        'kalori': kalori,
        'protein': protein,
        'karbohidrat': karbohidrat,
        'lemak': lemak,
        'status': 'active',
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  // CRUD Operations
  Future<List<Menu>> getAllMenus() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'menus',
        orderBy: 'tanggal ASC',
      );
      return List.generate(maps.length, (i) => Menu.fromMap(maps[i]));
    } catch (e) {
      print('Error getAllMenus: $e');
      return [];
    }
  }

  Future<Menu?> getMenuByDate(String tanggal) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'menus',
        where: 'tanggal = ?',
        whereArgs: [tanggal],
      );
      if (maps.isEmpty) return null;
      return Menu.fromMap(maps.first);
    } catch (e) {
      print('Error getMenuByDate: $e');
      return null;
    }
  }

  Future<int> insertMenu(Menu menu) async {
    try {
      final db = await database;
      return await db.insert('menus', menu.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('Error insertMenu: $e');
      return -1;
    }
  }

  Future<int> updateMenu(Menu menu) async {
    try {
      final db = await database;
      return await db.update(
        'menus',
        menu.toMap(),
        where: 'id = ?',
        whereArgs: [menu.id],
      );
    } catch (e) {
      print('Error updateMenu: $e');
      return -1;
    }
  }

  Future<int> deleteMenu(int id) async {
    try {
      final db = await database;
      return await db.delete('menus', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleteMenu: $e');
      return -1;
    }
  }

  Future<List<Menu>> getMenusByMonth(int year, int month) async {
    try {
      final db = await database;
      String monthStr = month.toString().padLeft(2, '0');
      final List<Map<String, dynamic>> maps = await db.query(
        'menus',
        where: "tanggal LIKE ?",
        whereArgs: ['$year-$monthStr-%'],
        orderBy: 'tanggal ASC',
      );
      return List.generate(maps.length, (i) => Menu.fromMap(maps[i]));
    } catch (e) {
      print('Error getMenusByMonth: $e');
      return [];
    }
  }

  Future<List<Menu>> getMenusByRange(String startDate, String endDate) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'menus',
        where: "tanggal BETWEEN ? AND ?",
        whereArgs: [startDate, endDate],
        orderBy: 'tanggal ASC',
      );
      return List.generate(maps.length, (i) => Menu.fromMap(maps[i]));
    } catch (e) {
      print('Error getMenusByRange: $e');
      return [];
    }
  }
}