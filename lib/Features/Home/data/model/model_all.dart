class TitleNewsModel {
  List<NewsGet>? news;

  TitleNewsModel({this.news});

  TitleNewsModel.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      news = <NewsGet>[];
      json['posts'].forEach((v) {
        news!.add(NewsGet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (news != null) {
      data['posts'] = news!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewsGet {
  int? id;
  int? categoryId;
  String? title;
  String? img;
  String? dateTime;

  NewsGet({this.id, this.categoryId, this.title, this.img, this.dateTime});

  factory NewsGet.fromJson(Map<String, dynamic> json) {
    return NewsGet(
      id: json['id'],
      categoryId: json['category_id'],
      title: json['title'],
      img: json['img'],
      dateTime: json['date_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'title': title,
      'img': img,
      'date_time': dateTime,
    };
  }
}
