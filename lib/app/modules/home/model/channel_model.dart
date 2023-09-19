
class ChannelInfo {

  final String id;
  final String videoCount;
  final String uploadPlaylistId;

  ChannelInfo({
    required this.id,
    required this.videoCount,
    required this.uploadPlaylistId,
  });

  factory ChannelInfo.fromJson(Map<String, dynamic> json)=> ChannelInfo(
    id: json['id'],
    videoCount: json['statistics']['videoCount'],
    uploadPlaylistId: json['contentDetails']['relatedPlaylists']['uploads'],
  );

}