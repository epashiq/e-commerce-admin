// import 'dart:convert';

// import 'package:e_commerce_admin/features/product/data/model/details_model.dart';

// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class ProductModel {
//   String? id;
//   String categoryId;
//   num mrpPrize;
//   String descreption;
//   num stock;
//   num offerPrize;
//   DetailsModel details;
//   ProductModel({
//     this.id,
//     required this.categoryId,
//     required this.mrpPrize,
//     required this.descreption,
//     required this.stock,
//     required this.offerPrize,
//     required this.details,
//   });

//   ProductModel copyWith({
//     String? id,
//     String? categoryId,
//     num? mrpPrize,
//     String? descreption,
//     num? stock,
//     num? offerPrize,
//     DetailsModel? details,
//   }) {
//     return ProductModel(
//       id: id ?? this.id,
//       categoryId: categoryId ?? this.categoryId,
//       mrpPrize: mrpPrize ?? this.mrpPrize,
//       descreption: descreption ?? this.descreption,
//       stock: stock ?? this.stock,
//       offerPrize: offerPrize ?? this.offerPrize,
//       details: details ?? this.details,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'categoryId': categoryId,
//       'mrpPrize': mrpPrize,
//       'descreption': descreption,
//       'stock': stock,
//       'offerPrize': offerPrize,
//       'details': details.toMap(),
//     };
//   }

//   factory ProductModel.fromMap(Map<String, dynamic> map) {
//     return ProductModel(
//       id: map['id'] != null ? map['id'] as String : null,
//       categoryId: map['categoryId'] as String,
//       mrpPrize: map['mrpPrize'] as num,
//       descreption: map['descreption'] as String,
//       stock: map['stock'] as num,
//       offerPrize: map['offerPrize'] as num,
//       details: DetailsModel.fromMap(map['details'] as Map<String,dynamic>),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ProductModel.fromJson(String source) =>
//       ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }

import 'dart:convert';

import 'package:e_commerce_admin/features/product/data/model/details_model.dart';

class ProductModel {
  String? id;
  String? categoryId;
  String product;
  num mrpPrize;
  String descreption;
  num stock;
  num offerPrize;
  DetailsModel details;
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
    DetailsModel? details,
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
      categoryId: map['categoryId'] != null ? map['categoryId'] as String : null,
      product: map['product'] as String,
      mrpPrize: map['mrpPrize'] as num,
      descreption: map['descreption'] as String,
      stock: map['stock'] as num,
      offerPrize: map['offerPrize'] as num,
      details: DetailsModel.fromMap(map['details'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
