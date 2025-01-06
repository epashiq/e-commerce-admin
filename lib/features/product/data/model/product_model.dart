// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:e_commerce_admin/features/details/data/model/detail_model.dart';

class ProductModel {
  String? id;
  String? categoryId;
  String product;
  num mrpPrize;
  String descreption;
  num stock;
  num offerPrize; 
  DetailModel details;
  ProductModel({
    this.id,
    this.categoryId,
    required this.product,
    required this.mrpPrize,
    required this.descreption,
    required this.stock,
    required this.offerPrize,
    required this.details,
  });

  ProductModel copyWith({
    String? id,
    String? categoryId,
    String? product,
    num? mrpPrize,
    String? descreption,
    num? stock,
    num? offerPrize,
    DetailModel? details,
  }) {
    return ProductModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      product: product ?? this.product,
      mrpPrize: mrpPrize ?? this.mrpPrize,
      descreption: descreption ?? this.descreption,
      stock: stock ?? this.stock,
      offerPrize: offerPrize ?? this.offerPrize,
      details: details ?? this.details,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoryId': categoryId,
      'product': product,
      'mrpPrize': mrpPrize,
      'descreption': descreption,
      'stock': stock,
      'offerPrize': offerPrize,
      'details': details.toMap(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'] as String : null,
      categoryId:
          map['categoryId'] != null ? map['categoryId'] as String : null,
      product: map['product'] as String,
      mrpPrize: map['mrpPrize'] as num,
      descreption: map['descreption'] as String,
      stock: map['stock'] as num,
      offerPrize: map['offerPrize'] as num,
      details: DetailModel.fromMap(map['details'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}



// import 'dart:convert';

// import 'package:e_commerce_admin/features/details/data/model/detail_model.dart';

// class ProductModel {
//   String? id;
//   String? categoryId;
//   String product;
//   num mrpPrize;
//   String descreption;
//   num stock;
//   num offerPrize; 
//   ProductModel({
//     this.id,
//     this.categoryId,
//     required this.product,
//     required this.mrpPrize,
//     required this.descreption,
//     required this.stock,
//     required this.offerPrize,
//   });

//   ProductModel copyWith({
//     String? id,
//     String? categoryId,
//     String? product,
//     num? mrpPrize,
//     String? descreption,
//     num? stock,
//     num? offerPrize,
//   }) {
//     return ProductModel(
//       id: id ?? this.id,
//       categoryId: categoryId ?? this.categoryId,
//       product: product ?? this.product,
//       mrpPrize: mrpPrize ?? this.mrpPrize,
//       descreption: descreption ?? this.descreption,
//       stock: stock ?? this.stock,
//       offerPrize: offerPrize ?? this.offerPrize,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'categoryId': categoryId,
//       'product': product,
//       'mrpPrize': mrpPrize,
//       'descreption': descreption,
//       'stock': stock,
//       'offerPrize': offerPrize,
//     };
//   }

//   factory ProductModel.fromMap(Map<String, dynamic> map) {
//     return ProductModel(
//       id: map['id'] != null ? map['id'] as String : null,
//       categoryId:
//           map['categoryId'] != null ? map['categoryId'] as String : null,
//       product: map['product'] as String,
//       mrpPrize: map['mrpPrize'] as num,
//       descreption: map['descreption'] as String,
//       stock: map['stock'] as num,
//       offerPrize: map['offerPrize'] as num,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ProductModel.fromJson(String source) =>
//       ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }





 







 

