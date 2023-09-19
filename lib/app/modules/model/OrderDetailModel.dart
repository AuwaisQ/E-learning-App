// To parse this JSON data, do
//
//     final PendingOrderList = PendingOrderListFromJson(jsonString);

import 'dart:convert';

List<PendingOrderList> PendingOrderListFromJson(String str) => List<PendingOrderList>.from(json.decode(str).map((x) => PendingOrderList.fromJson(x)));
String PendingOrderListToJson(List<PendingOrderList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PendingOrderList {
  final int orderId;
  final DateTime orderdate;
  final int ordertotal;
  final List<Productdetail> productdetails;

  PendingOrderList({
    required this.orderId,
    required this.orderdate,
    required this.ordertotal,
    required this.productdetails,
  });

  factory PendingOrderList.fromJson(Map<String, dynamic> json) => PendingOrderList(
    orderId: json["order_id"],
    orderdate: DateTime.parse(json["orderdate"]),
    ordertotal: json["ordertotal"],
    productdetails: List<Productdetail>.from(json["productdetails"].map((x) => Productdetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "orderdate": "${orderdate.year.toString().padLeft(4, '0')}-${orderdate.month.toString().padLeft(2, '0')}-${orderdate.day.toString().padLeft(2, '0')}",
    "ordertotal": ordertotal,
    "productdetails": List<dynamic>.from(productdetails.map((x) => x.toJson())),
  };
}

class Productdetail {
  final int productId;
  final String image;
  final String name;
  final String description;
  final String price;
  final String quantity;

  Productdetail({
    required this.productId,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
  });

  factory Productdetail.fromJson(Map<String, dynamic> json) => Productdetail(
    productId: json["product_id"],
    image: json["image"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "image": image,
    "name": name,
    "description": description,
    "price": price,
    "quantity": quantity,
  };
}


