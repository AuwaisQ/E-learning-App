// To parse this JSON data, do
//
//     final createProject = createProjectFromJson(jsonString);
import 'dart:convert';

CreateProject createProjectFromJson(String str) => CreateProject.fromJson(json.decode(str));

String createProjectToJson(CreateProject data) => json.encode(data.toJson());

class CreateProject {
  CreateProject({
    required this.userId,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.image,
    required this.materialUsed,
  });

  final String userId;
  final String title;
  final String description;
  final String startDate;
  final DateTime endDate;
  final String image;
  final List<MaterialUsed> materialUsed;

  factory CreateProject.fromJson(Map<String, dynamic> json) => CreateProject(
    userId: json["user_id"],
    title: json["title"],
    description: json["description"],
    startDate: json["start_date"],
    endDate: DateTime.parse(json["end_date"]),
    image: json["image"],
    materialUsed: List<MaterialUsed>.from(json["materialUsed"].map((x) => MaterialUsed.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "title": title,
    "description": description,
    "start_date": startDate,
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "image": image,
    "materialUsed": List<dynamic>.from(materialUsed.map((x) => x.toJson())),
  };
}

class MaterialUsed {
  MaterialUsed({
    required this.matName,
    required this.matQuantity,
  });

  final String matName;
  final String matQuantity;

  factory MaterialUsed.fromJson(Map<String, dynamic> json) => MaterialUsed(
    matName: json["matName"],
    matQuantity: json["matQuantity"],
  );

  Map<String, dynamic> toJson() => {
    "matName": matName,
    "matQuantity": matQuantity,
  };
}
