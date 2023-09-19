// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);
import 'dart:convert';

List<CommentModel> commentModelFromJson(String str) => List<CommentModel>.from(json.decode(str).map((x) => CommentModel.fromJson(x)));

String commentModelToJson(List<CommentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentModel {
    CommentModel({
        required this.id,
        required this.name,
        required this.comment,
    });

    int id;
    String name;
    String comment;

    factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["id"],
        name: json["name"],
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "comment": comment,
    };
}
