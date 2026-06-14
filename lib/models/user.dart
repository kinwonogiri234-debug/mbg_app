// supplier/models/user.dart
class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? phoneNumber;
  final String? address;
  final String username;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.phoneNumber,
    this.address,
    required this.username,
  });

  // Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      username: json['username'] ?? '',
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'phoneNumber': phoneNumber,
      'address': address,
      'username' :username,
    };
  }

  // Copy with updated values
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    String? phoneNumber,
    String? address,
    String? username,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      username: username?? this.username,
    );
  }
}