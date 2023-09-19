import 'dart:convert';

List<Comments> commentsFromJson(String str) => List<Comments>.from(json.decode(str).map((x) => Comments.fromJson(x)));
String commentsToJson(List<Comments> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class Comments {
  Comments({
    required this.name,
    required this.userid,
    required this.projectid,
    required this.comment,
  });

  final String name;
  final int userid;
  final int projectid;
  final String comment;

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
    name: json["name"],
    userid: json["userid"],
    projectid: json["projectid"],
    comment: json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "userid": userid,
    "projectid": projectid,
    "comment": comment,
  };
}


//----Get Likes----
List<Likes> likesFromJson(String str) => List<Likes>.from(json.decode(str).map((x) => Likes.fromJson(x)));
String likesToJson(List<Likes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class Likes {
  Likes({
    required this.likeType,
  });
  String likeType;
  factory Likes.fromJson(Map<String, dynamic> json) => Likes(
    likeType: json["like_type"],
  );
  Map<String, dynamic> toJson() => {
    "like_type": likeType,
  };
}



//----Like Type Model----
List<LikeType> likeTypeFromJson(String str) => List<LikeType>.from(json.decode(str).map((x) => LikeType.fromJson(x)));
String likeTypeToJson(List<LikeType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class LikeType {
  LikeType({
    required this.likeTypeId,
    required this.count,
  });

  int likeTypeId;
  int count;

  factory LikeType.fromJson(Map<String, dynamic> json) => LikeType(
    likeTypeId: json["like_type_id"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "like_type_id": likeTypeId,
    "count": count,
  };
}
