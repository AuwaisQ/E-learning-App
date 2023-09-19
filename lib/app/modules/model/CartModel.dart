// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

List<CartModel> cartModelFromJson(String str) => List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel {
  int cartId;
  int productId;
  String productName;
  String price;
  String quantity;
  String image;
  String description;

  CartModel({
    required this.cartId,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.image,
    required this.description,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    cartId: json["cart_id"],
    productId: json["product_id"],
    productName: json["product_name"],
    price: json["price"],
    quantity: json["quantity"],
    image: json["image"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "cart_id": cartId,
    "product_id": productId,
    "product_name": productName,
    "price": price,
    "quantity": quantity,
    "image": image,
    "description": description,
  };
}
