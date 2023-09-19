class VideoModel {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String channelTitle;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.channelTitle,
  });

  factory VideoModel.fromJson(Map<String, dynamic> snippet) => VideoModel(
    id: snippet['resourceId']['videoId'],
    title: snippet['title'],
    description: snippet['description'],
    thumbnailUrl: snippet['thumbnails']['high']['url'],
    channelTitle: snippet['channelTitle'],
  );
}