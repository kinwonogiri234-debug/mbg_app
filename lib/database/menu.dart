class Menu {

  final int? id;
  final String tanggal;
  final String hari;
  final String menu; // Satu menu per hari (1 kali sehari)
  final double kalori;
  final double protein;
  final double karbohidrat;
  final double lemak;
  final String status;

  Menu({
    this.id,
    required this.tanggal,
    required this.hari,
    required this.menu,
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
      'menu': menu,
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
      menu: map['menu'],
      kalori: map['kalori'],
      protein: map['protein'],
      karbohidrat: map['karbohidrat'],
      lemak: map['lemak'],
      status: map['status'],
    );
  }
}