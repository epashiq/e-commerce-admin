// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';

// class PersonModel {
//   String? id;
//   String name;
//   String place;
//   String descreption;
//   Timestamp createdAt;
//   num like;
//   PersonModel({
//     this.id,
//     required this.name,
//     required this.place,
//     required this.descreption,
//     required this.createdAt,
//     required this.like,
//   });

//   PersonModel copyWith({
//     String? id,
//     String? name,
//     String? place,
//     String? descreption,
//     Timestamp? createdAt,
//     num? like,
//   }) {
//     return PersonModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       place: place ?? this.place,
//       descreption: descreption ?? this.descreption,
//       createdAt: createdAt ?? this.createdAt,
//       like: like ?? this.like,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'name': name,
//       'place': place,
//       'descreption': descreption,
//       'createdAt': createdAt,
//       'like': like,
//     };
//   }

//   factory PersonModel.fromMap(Map<String, dynamic> map) {
//     return PersonModel(
//       id: map['id'] != null ? map['id'] as String : null,
//       name: map['name'] as String,
//       place: map['place'] as String,
//       descreption: map['descreption'] as String,
//       createdAt: map['createdAt'] as Timestamp,
//       like: map['like'] != null ? map['like'] as num :0,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory PersonModel.fromJson(String source) => PersonModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PersonModel {
  String? id;
  String name;
  String place;
  String descreption;
  Timestamp createdAt;
  num like;
  String? imageUrl;
  PersonModel({
    this.id,
    required this.name,
    required this.place,
    required this.descreption,
    required this.createdAt,
    required this.like,
    this.imageUrl,
  });

  PersonModel copyWith({
    String? id,
    String? name,
    String? place,
    String? descreption,
    Timestamp? createdAt,
    num? like,
    String? imageUrl,
  }) {
    return PersonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      place: place ?? this.place,
      descreption: descreption ?? this.descreption,
      createdAt: createdAt ?? this.createdAt,
      like: like ?? this.like,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'place': place,
      'descreption': descreption,
      'createdAt': createdAt,
      'like': like,
      'imageUrl': imageUrl,
    };
  }

  factory PersonModel.fromMap(Map<String, dynamic> map) {
    return PersonModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      place: map['place'] as String,
      descreption: map['descreption'] as String,
      createdAt: map['createdAt'] as Timestamp,
      like: map['like'] !=null ? map['like'] as num : 0,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonModel.fromJson(String source) => PersonModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

