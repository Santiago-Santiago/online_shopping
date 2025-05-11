import 'dart:convert';

class InventoryMovement {
  final int movement_id;
  final String transaction_code;
  final DateTime transaction_date;
  final String operation_sign;
  final String product_code;
  final String sales_unit;
  final int quantity;
  final String status;

  InventoryMovement({
    required this.movement_id,
    required this.transaction_code,
    required this.transaction_date,
    required this.operation_sign,
    required this.product_code,
    required this.sales_unit,
    required this.quantity,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'movement_id': movement_id,
      'transaction_code': transaction_code,
      'transaction_date': transaction_date.toIso8601String(),
      'operation_sign': operation_sign,
      'product_code': product_code,
      'sales_unit': sales_unit,
      'quantity': quantity,
      'status': status,
    };
  }

  factory InventoryMovement.fromMap(Map<String, dynamic> map) {
    return InventoryMovement(
      movement_id: map['movement_id'],
      transaction_code: map['transaction_code'],
      transaction_date: DateTime.parse(map['transaction_date']),
      operation_sign: map['operation_sign'],
      product_code: map['product_code'],
      sales_unit: map['sales_unit'],
      quantity: map['quantity'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryMovement.fromJson(String source) =>
      InventoryMovement.fromMap(json.decode(source));
}
