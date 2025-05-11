import 'dart:convert';

class Stock {
  final String product_code;
  final int reserved_stock;
  final int physical_stock;

  Stock({
    required this.product_code,
    required this.reserved_stock,
    required this.physical_stock,
  });

  Map<String, dynamic> toMap() {
    return {
      'product_code': product_code,
      'reserved_stock': reserved_stock,
      'physical_stock': physical_stock,
    };
  }

  factory Stock.fromMap(Map<String, dynamic> map) {
    return Stock(
      product_code: map['product_code'],
      reserved_stock: map['reserved_stock'],
      physical_stock: map['physical_stock'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Stock.fromJson(String source) => Stock.fromMap(json.decode(source));
}
