// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';

// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class DetailModel {
//   String? id;
//   String productId;
//   String proMaterial;
//   String proColour;
//   String production;
//   Timestamp createdAt;

//   DetailModel({
//     this.id,
//     required this.productId,
//     required this.proMaterial,
//     required this.proColour,
//     required this.production,
//     required this.createdAt,
//   });

//   DetailModel copyWith({
//     String? id,
//     String? productId,
//     String? proMaterial,
//     String? proColour,
//     String? production,
//     Timestamp? createdAt,
//   }) {
//     return DetailModel(
//       id: id ?? this.id,
//       productId: productId ?? this.productId,
//       proMaterial: proMaterial ?? this.proMaterial,
//       proColour: proColour ?? this.proColour,
//       production: production ?? this.production,
//       createdAt: createdAt ?? this.createdAt,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'productId': productId,
//       'proMaterial': proMaterial,
//       'proColour': proColour,
//       'production': production,
//       'createdAt': createdAt,
//     };
//   }

//   factory DetailModel.fromMap(Map<String, dynamic> map) {
//     return DetailModel(
//       id: map['id'] != null ? map['id'] as String : null,
//       productId: map['productId'] as String,
//       proMaterial: map['proMaterial'] as String,
//       proColour: map['proColour'] as String,
//       production: map['production'] as String,
//       createdAt: map['createdAt'] as Timestamp ,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory DetailModel.fromJson(String source) =>
//       DetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }


import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DetailModel {
  String? id;
  String proMaterial;
  String proColour;
  String production;
  Timestamp createdAt;

  DetailModel({
    this.id,
    required this.proMaterial,
    required this.proColour,
    required this.production,
    required this.createdAt,
  });

  DetailModel copyWith({
    String? id,
    String? proMaterial,
    String? proColour,
    String? production,
    Timestamp? createdAt,
  }) {
    return DetailModel(
      id: id ?? this.id,
      proMaterial: proMaterial ?? this.proMaterial,
      proColour: proColour ?? this.proColour,
      production: production ?? this.production,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'proMaterial': proMaterial,
      'proColour': proColour,
      'production': production,
      'createdAt': createdAt,
    };
  }

  factory DetailModel.fromMap(Map<String, dynamic> map) {
    return DetailModel(
      id: map['id'] != null ? map['id'] as String : null,
      proMaterial: map['proMaterial'] as String,
      proColour: map['proColour'] as String,
      production: map['production'] as String,
      createdAt: map['createdAt'] as Timestamp ,
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailModel.fromJson(String source) =>
      DetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

