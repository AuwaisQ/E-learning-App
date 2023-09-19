// To parse this JSON data, do
//
//     final videoDisplayModel = videoDisplayModelFromJson(jsonString);

import 'dart:convert';

List<VideoDisplayModel> videoDisplayModelFromJson(String str) => List<VideoDisplayModel>.from(json.decode(str).map((x) => VideoDisplayModel.fromJson(x)));

String videoDisplayModelToJson(List<VideoDisplayModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VideoDisplayModel {
  VideoDisplayModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.thumble,
    required this.author,
    required this.rating,
  });

  int id;
  String title;
  String subTitle;
  String description;
  String thumble;
  String author;
  String rating;

  factory VideoDisplayModel.fromJson(Map<String, dynamic> json) => VideoDisplayModel(
    id: json["id"],
    title: json["title"],
    subTitle: json["sub_title"],
    description: json["description"],
    thumble: json["thumble"],
    author: json["author"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "sub_title": subTitle,
    "description": description,
    "thumble": thumble,
    "author": author,
    "rating": rating,
  };
}
