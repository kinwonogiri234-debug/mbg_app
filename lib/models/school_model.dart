class SchoolModel {
  final String id;
  final String name;
  final String address;
  final int students;

  SchoolModel({
    required this.id,
    required this.name,
    required this.address,
    required this.students,
  });

  // Convert to Map for easier manipulation
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'students': students,
    };
  }

  // Create from Map
  factory SchoolModel.fromMap(Map<String, dynamic> map) {
    return SchoolModel(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      students: map['students'],
    );
  }

  // Copy with new values
  SchoolModel copyWith({
    String? id,
    String? name,
    String? address,
    int? students,
  }) {
    return SchoolModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      students: students ?? this.students,
    );
  }
}