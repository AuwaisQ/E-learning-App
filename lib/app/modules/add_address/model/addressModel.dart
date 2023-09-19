
import 'dart:convert';

List<Address> addressFromJson(String str) => List<Address>.from(json.decode(str).map((x) => Address.fromJson(x)));

String addressToJson(List<Address> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Address {
  Address({
    required this.id,
    required this.type,
    required this.address,
    required this.cityid,
  });

  int id;
  String type;
  String address;
  String cityid;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    type: json["type"],
    address: json["address"],
    cityid: json["cityid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "address": address,
    "cityid": cityid,
  };
}


List<CityIdModel> cityIdModelFromJson(String str) => List<CityIdModel>.from(json.decode(str).map((x) => CityIdModel.fromJson(x)));

String cityIdModelToJson(List<CityIdModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityIdModel {
  CityIdModel({
    required this.id,
    required this.city,
    required this.state_id,
  });

  int id;
  String city;
  int state_id;

  factory CityIdModel.fromJson(Map<String, dynamic> json) => CityIdModel(
    id: json["id"],
    city: json["city"],
    state_id: json["state_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "city": city,
    "state_id": state_id,
  };
}