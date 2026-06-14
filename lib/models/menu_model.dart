class Menu {
  final int? id;
  final String tanggal; // format: YYYY-MM-DD
  final String hari;
  final String menuPagi;
  final String menuSiang;
  final String menuMalam;
  final double kalori;
  final double protein;
  final double karbohidrat;
  final double lemak;
  final String status; // active/inactive

  Menu({
    this.id,
    required this.tanggal,
    required this.hari,
    required this.menuPagi,
    required this.menuSiang,
    required this.menuMalam,
    required this.kalori,
    required this.protein,
    required this.karbohidrat,
    required this.lemak,
    this.status = 'active',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tanggal': tanggal,
      'hari': hari,
      'menu_pagi': menuPagi,
      'menu_siang': menuSiang,
      'menu_malam': menuMalam,
      'kalori': kalori,
      'protein': protein,
      'karbohidrat': karbohidrat,
      'lemak': lemak,
      'status': status,
    };
  }

  factory Menu.fromMap(Map<String, dynamic> map) {
    return Menu(
      id: map['id'],
      tanggal: map['tanggal'],
      hari: map['hari'],
      menuPagi: map['menu_pagi'],
      menuSiang: map['menu_siang'],
      menuMalam: map['menu_malam'],
      kalori: map['kalori'],
      protein: map['protein'],
      karbohidrat: map['karbohidrat'],
      lemak: map['lemak'],
      status: map['status'],
    );
  }
}