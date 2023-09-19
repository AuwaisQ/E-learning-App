// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

List<HomeModel> homeModelFromJson(String str) => List<HomeModel>.from(json.decode(str).map((x) => HomeModel.fromJson(x)));

String homeModelToJson(List<HomeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeModel {
  HomeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumble,
    required this.author,
    required this.rating,
  });

  int id;
  String title;
  String description;
  String thumble;
  String author;
  String rating;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    thumble: json["thumble"],
    author: json["author"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "thumble": thumble,
    "author": author,
    "rating": rating,
  };
}
