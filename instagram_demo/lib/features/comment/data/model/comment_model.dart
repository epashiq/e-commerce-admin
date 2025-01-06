// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';

// class CommentModel {
//   String? id;
//   String personId;
//   String comment;
//   Timestamp createdAt;
//   CommentModel({
//     this.id,
//     required this.personId,
//     required this.comment,
//     required this.createdAt,
//   });

//   CommentModel copyWith({
//     String? id,
//     String? personId,
//     String? comment,
//     Timestamp? createdAt,
//   }) {
//     return CommentModel(
//       id: id ?? this.id,
//       personId: personId ?? this.personId,
//       comment: comment ?? this.comment,
//       createdAt: createdAt ?? this.createdAt,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'personId': personId,
//       'comment': comment,
//       'createdAt': createdAt,
//     };
//   }

//   factory CommentModel.fromMap(Map<String, dynamic> map) {
//     return CommentModel(
//       id: map['id'] != null ? map['id'] as String : null,
//       personId: map['personId'] as String,
//       comment: map['comment'] as String,
//       createdAt: map['createdAt'] as Timestamp,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory CommentModel.fromJson(String source) =>
//       CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? id;
  String personId;
  String comment;
  Timestamp createdAt;
  num commentCount;
  CommentModel({
    this.id,
    required this.personId,
    required this.comment,
    required this.createdAt,
    required this.commentCount,
  });

  CommentModel copyWith({
    String? id,
    String? personId,
    String? comment,
    Timestamp? createdAt,
    num? commentCount,
  }) {
    return CommentModel(
      id: id ?? this.id,
      personId: personId ?? this.personId,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      commentCount: commentCount ?? this.commentCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'personId': personId,
      'comment': comment,
      'createdAt': createdAt,
      'commentCount': commentCount,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] != null ? map['id'] as String : null,
      personId: map['personId'] as String,
      comment: map['comment'] as String,
      createdAt: map['createdAt'] as Timestamp,
      commentCount:
          map['commentCount'] != null ? map['commentCount'] as num : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
