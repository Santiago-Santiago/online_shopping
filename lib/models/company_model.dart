import 'dart:convert';

class Company {
  final int company_id;
  final String ruc;
  final String business_name;
  final String address;
  final String ubigeo_code;
  final String status;

  Company({
    required this.company_id,
    required this.ruc,
    required this.business_name,
    required this.address,
    required this.ubigeo_code,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'company_id': company_id,
      'ruc': ruc,
      'business_name': business_name,
      'address': address,
      'ubigeo_code': ubigeo_code,
      'status': status,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      company_id: map['company_id'] as int,
      ruc: map['ruc'],
      business_name: map['business_name'],
      address: map['address'],
      ubigeo_code: map['ubigeo_code'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source));
}
