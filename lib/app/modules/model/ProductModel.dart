// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);
import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    required this.itemId,
    required this.categoryId,
    required this.productName,
    required this.image,
    required this.description,
    required this.price,
  });

  int itemId;
  dynamic categoryId;
  String productName;
  String image;
  String description;
  String price;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    itemId: json["id"],
    categoryId: json["category_id"],
    productName: json["product_name"],
    image: json["image"],
    description: json["description"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": itemId,
    "category_id": categoryId,
    "product_name": productName,
    "image": image,
    "description": description,
    "price": price,
  };
}
