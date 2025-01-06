import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DetailsModel {
  String? id;
  String material;
  String colour;
  Timestamp createdAt;
  DetailsModel({
    this.id,
    required this.material,
    required this.colour,
    required this.createdAt,
  });

  DetailsModel copyWith({
    String? id,
    String? material,
    String? colour,
    Timestamp? createdAt,
  }) {
    return DetailsModel(
      id: id ?? this.id,
      material: material ?? this.material,
      colour: colour ?? this.colour,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'material': material,
      'colour': colour,
      'createdAt': createdAt,
    };
  }

  factory DetailsModel.fromMap(Map<String, dynamic> map) {
    return DetailsModel(
      id: map['id'] != null ? map['id'] as String : null,
      material: map['material'] as String,
      colour: map['colour'] as String,
      createdAt: map['createdAt'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailsModel.fromJson(String source) =>
      DetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
