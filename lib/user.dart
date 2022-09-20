// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserDetails {
  final int? id;
  final String name;
  final String email;
  final String address;
  final int phone;
  UserDetails({
    this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      phone: map['phone'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetails.fromJson(String source) =>
      UserDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}
