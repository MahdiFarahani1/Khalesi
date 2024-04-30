class VideosModel {
  int? id;

  String? title;

  String? youtube;
  String? video_url;

  VideosModel({
    this.id,
    this.title,
    this.video_url,
    this.youtube,
  });

  VideosModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    youtube = json['youtube'];
    video_url = json['video_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['video_url'] = video_url;
    data['title'] = title;
    data['youtube'] = youtube;
    return data;
  }
}
