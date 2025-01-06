// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? id;
  String userId;
  String descreption;
  num likecount;
  Timestamp createdAt;
  PostModel({
    this.id,
    required this.userId,
    required this.descreption,
    required this.likecount,
    required this.createdAt,
  });

  PostModel copyWith({
    String? id,
    String? userId,
    String? descreption,
    num? likecount,
    Timestamp? createdAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      descreption: descreption ?? this.descreption,
      likecount: likecount ?? this.likecount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'descreption': descreption,
      'likecount': likecount,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] != null ? map['id'] as String : null,
      userId: map['userId'] as String,
      descreption: map['descreption'] as String,
      likecount: map['likecount'] as num,
      createdAt: map['createdAt'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
