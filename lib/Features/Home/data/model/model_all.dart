class NewsGet {
  int? id;
  int? categoryId;
  String? title;
  String? img;
  String? dateTime;
  String? categoryTitle;
  NewsGet(
      {this.id,
      this.categoryId,
      this.title,
      this.img,
      this.dateTime,
      this.categoryTitle});

  factory NewsGet.fromJson(Map<String, dynamic> json) {
    return NewsGet(
      categoryTitle: json["category_title"],
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
      'category_title': categoryTitle,
    };
  }
}
