
import 'dart:convert';

//----Completed-ProjectList-Model----
List<CompletedProjectList> completedProjectListFromJson(String str) => List<CompletedProjectList>.from(json.decode(str).map((x) => CompletedProjectList.fromJson(x)));
String completedProjectListToJson(List<CompletedProjectList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class CompletedProjectList {
  int id;
  String title;
  int userId;
  DateTime startDate;
  DateTime endDate;
  String videoUrl;
  dynamic youtubeUrl;
  String category;
  String progress;
  String projectImage;
  String description;
  int status;

  CompletedProjectList({
    required this.id,
    required this.title,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.videoUrl,
    required this.youtubeUrl,
    required this.category,
    required this.progress,
    required this.projectImage,
    required this.description,
    required this.status,
  });

  factory CompletedProjectList.fromJson(Map<String, dynamic> json) => CompletedProjectList(
    id: json["id"],
    title: json["title"],
    userId: json["user_id"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    videoUrl: json["video_url"],
    youtubeUrl: json["youtube_url"],
    category: json["category"],
    progress: json["progress"],
    projectImage: json["projectImage"],
    description: json["description"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "user_id": userId,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "video_url": videoUrl,
    "youtube_url": youtubeUrl,
    "category": category,
    "progress": progress,
    "projectImage": projectImage,
    "description": description,
    "status": status,
  };
}


//----OnGoing-ProjectList-Model----
List<OngoingProjectList> onGoingProjectListFromJson(String str) => List<OngoingProjectList>.from(json.decode(str).map((x) => OngoingProjectList.fromJson(x)));
String onGoingProjectListToJson(List<OngoingProjectList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OngoingProjectList {
  OngoingProjectList({
    required this.id,
    required this.title,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.videoUrl,
    required this.category,
    required this.progress,
    required this.projectImage,
    required this.description,
    required this.materialused,
    required this.status,
  });

  int id;
  String title;
  int userId;
  DateTime startDate;
  DateTime endDate;
  String videoUrl;
  String category;
  String progress;
  dynamic projectImage;
  dynamic description;
  List<Materialused> materialused;
  int status;

  factory OngoingProjectList.fromJson(Map<String, dynamic> json) => OngoingProjectList(
    id: json["id"],
    title: json["title"],
    userId: json["user_id"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    videoUrl: json["video_url"],
    category: json["category"],
    progress: json["progress"],
    projectImage: json["projectImage"],
    description: json["description"],
    materialused: List<Materialused>.from(json["materialused"].map((x) => Materialused.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "user_id": userId,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "video_url": videoUrl,
    "category": category,
    "progress": progress,
    "projectImage": projectImage,
    "description": description,
    "materialused": List<dynamic>.from(materialused.map((x) => x.toJson())),
    "status": status,
  };
}

class Materialused {
  Materialused({
    required this.id,
    required this.name,
    required this.quantity,
  });

  int id;
  String name;
  int quantity;

  factory Materialused.fromJson(Map<String, dynamic> json) => Materialused(
    id: json["id"],
    name: json["name"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "quantity": quantity,
  };
}