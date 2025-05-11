import 'dart:convert';

class Client {
  final int client_id;
  final String first_name;
  final String last_name_father;
  final String last_name_mother;
  final String phone_number;
  final String email;
  final String status;

  Client({
    required this.client_id,
    required this.first_name,
    required this.last_name_father,
    required this.last_name_mother,
    required this.phone_number,
    required this.email,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'client_id': client_id,
      'first_name': first_name,
      'last_name_father': last_name_father,
      'last_name_mother': last_name_mother,
      'phone_number': phone_number,
      'email': email,
      'status': status,
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      client_id: map['client_id'] as int,
      first_name: map['first_name'],
      last_name_father: map['last_name_father'],
      last_name_mother: map['last_name_mother'],
      phone_number: map['phone_number'],
      email: map['email'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Client.fromJson(String source) => Client.fromMap(json.decode(source));
}
