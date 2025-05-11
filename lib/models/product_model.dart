import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String product_code;
  final String description;
  final String sales_unit;
  final String category_code;
  final String subcategory_code;
  final String unit_content;
  final String additional_info;
  final String status;
  final String product_image_url;
  final String currency;
  final double sale_value;
  final double tax_rate;
  final double sale_price;

  Product({
    required this.product_code,
    required this.description,
    required this.sales_unit,
    required this.category_code,
    required this.subcategory_code,
    required this.unit_content,
    required this.additional_info,
    required this.status,
    required this.product_image_url,
    required this.currency,
    required this.sale_value,
    required this.tax_rate,
    required this.sale_price,
  });

  @override
  String toString() {
    return 'Producto(product_code: $product_code, description: $description, sales_unit: $sales_unit, category_code: $category_code, subcategory_code: $subcategory_code, unit_content: $unit_content, additional_info: $additional_info, status: $status, product_image_url: $product_image_url, currency: $currency, sale_value: $sale_value, tax_rate: $tax_rate, sale_price: $sale_price)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_code': product_code,
      'description': description,
      'sales_unit': sales_unit,
      'category_code': category_code,
      'subcategory_code': subcategory_code,
      'unit_content': unit_content,
      'additional_info': additional_info,
      'status': status,
      'product_image_url': product_image_url,
      'currency': currency,
      'sale_value': sale_value,
      'tax_rate': tax_rate,
      'sale_price': sale_price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      product_code: map['product_code'] as String,
      description: map['description'] as String,
      sales_unit: map['sales_unit'] as String,
      category_code: map['category_code'] as String,
      subcategory_code: map['subcategory_code'] as String,
      unit_content: map['unit_content'] as String,
      additional_info: map['additional_info'] as String,
      status: map['status'] as String,
      product_image_url: map['product_image_url'] as String,
      currency: map['currency'] as String,
      sale_value: map['sale_value'] as double,
      tax_rate: map['tax_rate'] as double,
      sale_price: map['sale_price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
