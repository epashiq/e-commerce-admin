// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String name;
  final String address;
  final String number;

  UserModel({
    required this.name,
    required this.address,
    required this.number,
  });

  UserModel copyWith({
    String? name,
    String? address,
    String? number,
  }) {
    return UserModel(
      name: name ?? this.name,
      address: address ?? this.address,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'address': address,
      'number': number,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      address: map['address'] as String,
      number: map['number'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
