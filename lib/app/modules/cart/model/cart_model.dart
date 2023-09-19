import 'dart:convert';


List<CartListModel> cartListModelFromJson(String str) => List<CartListModel>.from(json.decode(str).map((x) => CartListModel.fromJson(x)));
String cartListModelToJson(List<CartListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class CartListModel {
  CartListModel({
    required this.userId,
    required this.productId,
    required this.productName,
    required this.image,
    required this.price,
    required this.quantity,
  });

  int userId;
  int productId;
  String productName;
  String image;
  int price;
  int quantity;

  factory CartListModel.fromJson(Map<String, dynamic> json) => CartListModel(
    userId: json["userid"],
    productId: json["product_id"],
    productName: json["product_name"],
    image: json["image"],
    price: json["price"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "userid": userId,
    "product_id": productId,
    "product_name": productName,
    "image": quantity,
    "price": price,
    "quantity": image,
  };
}
