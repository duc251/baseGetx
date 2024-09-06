// To parse this JSON data, do
//
//     final importReceiptModel = importReceiptModelFromJson(jsonString);

import 'package:equatable/equatable.dart';

class ReceiptModel extends Equatable {
  final int? id;
  final String? receiptCode;
  final DateTime? createdAt;
  final String? status;
  final String? warehouseImport;
  final String? warehouseExport;
  final Order? order;

  const ReceiptModel({
    this.id,
    this.receiptCode,
    this.warehouseExport,
    this.createdAt,
    this.status,
    this.warehouseImport,
    this.order,
  });

  ReceiptModel copyWith({
    int? id,
    String? receiptCode,
    DateTime? createdAt,
    String? status,
    String? warehouseImport,
    Order? order,
  }) =>
      ReceiptModel(
        id: id ?? this.id,
        receiptCode: receiptCode ?? this.receiptCode,
        createdAt: createdAt ?? this.createdAt,
        status: status ?? this.status,
        warehouseImport: warehouseImport ?? this.warehouseImport,
        order: order ?? this.order,
      );

  factory ReceiptModel.fromJson(Map<String, dynamic> json) => ReceiptModel(
        id: json["id"],
        receiptCode: json["receipt_code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        status: json["status"],
        warehouseImport: json["warehouse_import"],
        warehouseExport: json["warehouse_export"],
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "receipt_code": receiptCode,
        "created_at": createdAt?.toIso8601String(),
        "status": status,
        "warehouse_import": warehouseImport,
        "warehouse_export": warehouseExport,
        "order": order?.toJson(),
      };

  @override
  List<Object?> get props => [id, receiptCode];
}

class Order {
  final String? orderCode;
  final Customer? customer;
  final int? orderId;

  Order({
    this.orderCode,
    this.customer,
    this.orderId,
  });

  Order copyWith({
    String? orderCode,
    Customer? customer,
    int? orderId,
  }) =>
      Order(
        orderCode: orderCode ?? this.orderCode,
        customer: customer ?? this.customer,
        orderId: orderId ?? this.orderId,
      );

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderCode: json["order_code"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        orderId: json["order_id"],
      );

  Map<String, dynamic> toJson() => {
        "order_code": orderCode,
        "customer": customer?.toJson(),
        "order_id": orderId,
      };
}

class Customer {
  final int? id;
  final String? fullname;
  final int? accountId;

  Customer({
    this.id,
    this.fullname,
    this.accountId,
  });

  Customer copyWith({
    int? id,
    String? fullname,
    int? accountId,
  }) =>
      Customer(
        id: id ?? this.id,
        fullname: fullname ?? this.fullname,
        accountId: accountId ?? this.accountId,
      );

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        fullname: json["fullname"],
        accountId: json["account_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "account_id": accountId,
      };
}
