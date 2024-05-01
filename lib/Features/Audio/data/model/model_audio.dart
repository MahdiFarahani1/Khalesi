class AudioModel {
  int? id;
  String? title;
  int? categoryId;
  Null content;
  String? soundUrl;

  AudioModel(
      {this.id, this.title, this.categoryId, this.content, this.soundUrl});

  AudioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    categoryId = json['category_id'];
    content = json['content'];
    soundUrl = json['sound_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['category_id'] = categoryId;
    data['content'] = content;
    data['sound_url'] = soundUrl;
    return data;
  }
}
