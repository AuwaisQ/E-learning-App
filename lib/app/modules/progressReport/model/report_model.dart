import 'dart:convert';

List<LikeTypeList> likeTypeListFromJson(String str) => List<LikeTypeList>.from(json.decode(str).map((x) => LikeTypeList.fromJson(x)));

String likeTypeListToJson(List<LikeTypeList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LikeTypeList {
  String materialName;
  int count;

  LikeTypeList({
    required this.materialName,
    required this.count,
  });

  factory LikeTypeList.fromJson(Map<String, dynamic> json) => LikeTypeList(
    materialName: json["MaterialName"],
    count: json["Count"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialName": materialName,
    "Count": count,
  };
}