// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/features/order/data/model/enum_order.dart';


class OrderModel {
  String? userId;
  String? orderId;
  Timestamp createdAt;
  Map<String, Map<String, dynamic>>? productModel;
  OrderStatus orderStatus;
  OrderModel({
    this.userId,
    this.orderId,
    required this.createdAt,
    this.productModel,
    required this.orderStatus,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'orderId': orderId,
      'createdAt': createdAt,
      'productModel': productModel,
      'orderStatus': orderStatus.name,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      userId: map['userId'] != null ? map['userId'] as String : null,
      orderId: map['orderId'] != null ? map['orderId'] as String : null,
      createdAt: map['createdAt'] as Timestamp,
      productModel: map['productModel'] != null ? Map<String, Map<String, dynamic>>.from(map['productModel'] as Map) : null,
      orderStatus: OrderStatus.values.firstWhere(
        (status) => status.name==map["orderStatus"],
        orElse: () => OrderStatus.shipping,
      )
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  OrderModel copyWith({
    String? userId,
    String? orderId,
    Timestamp? createdAt,
    Map<String, Map<String, dynamic>>? productModel,
    OrderStatus? orderStatus,
  }) {
    return OrderModel(
      userId: userId ?? this.userId,
      orderId: orderId ?? this.orderId,
      createdAt: createdAt ?? this.createdAt,
      productModel: productModel ?? this.productModel,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }
}