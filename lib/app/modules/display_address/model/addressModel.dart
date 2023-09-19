import 'dart:convert';

List<Address> addressFromJson(String str) => List<Address>.from(json.decode(str).map((x) => Address.fromJson(x)));
String addressToJson(List<Address> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Address {
  int id;
  String address;
  String city;
  String state;

  Address({
    required this.id,
    required this.address,
    required this.city,
    required this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "city": city,
    "state": state,
  };
}