import 'dart:convert';

List<NameIdModel> nameIdModelFromJson(String str) => List<NameIdModel>.from(json.decode(str).map((x) => NameIdModel.fromJson(x)));

String nameIdModelToJson(List<NameIdModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NameIdModel {
  NameIdModel({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory NameIdModel.fromJson(Map<String, dynamic> json) => NameIdModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}