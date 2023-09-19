// To parse this JSON data, do
//
//     final materialModel = materialModelFromJson(jsonString);
import 'dart:convert';

List<MaterialModel> getMaterialModelFromJson(String str) => List<MaterialModel>.from(json.decode(str).map((x) => MaterialModel.fromJson(x)));
String getMaterialModelToJson(List<MaterialModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaterialModel {
  MaterialModel({
    required this.materialId,
    required this.name,
    required this.image,
    required this.price,
    required this.qty,
    required this.isSelected,
  });

  int materialId;
  String name;
  String image;
  int price;
  int qty;
  bool isSelected;

  factory MaterialModel.fromJson(Map<String, dynamic> json) => MaterialModel(
    materialId: json["material_id"],
    name: json["name"],
    image: json["image"],
    price: json["price"],
    qty: json["qty"],
    isSelected: json["isSelected"],
  );

  Map<String, dynamic> toJson() => {
    "material_id": materialId,
    "name": name,
    "image": image,
    "price": price,
    "qty": qty,
    "isSelected": isSelected,
  };
}


//Material List
List<MaterialListModel> getMaterialListModelFromJson(String str) => List<MaterialListModel>.from(json.decode(str).map((x) => MaterialModel.fromJson(x)));
String getMaterialListModelToJson(List<MaterialModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaterialListModel {
  MaterialListModel({
    required this.matName,
    required this.matQuantity,
  });

  String matName;
  String matQuantity;

  factory MaterialListModel.fromJson(Map<String, dynamic> json) => MaterialListModel(
    matName: json["matName"],
    matQuantity: json["matQuantity"],
  );

  Map<String, dynamic> toJson() => {
    "matName": matName,
    "matQuantity": matQuantity,
  };
}
