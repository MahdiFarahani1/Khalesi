class PdfModel {
  int? id;
  int? categoryId;
  String? title;
  String? img;
  String? dateTime;
  String? categoryTitle;
  String? pdf;

  PdfModel(
      {this.id,
      this.categoryId,
      this.title,
      this.img,
      this.dateTime,
      this.categoryTitle,
      this.pdf});

  PdfModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    img = json['img'];
    dateTime = json['date_time'];
    categoryTitle = json['category_title'];
    pdf = json['pdf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['title'] = title;
    data['img'] = img;
    data['date_time'] = dateTime;
    data['category_title'] = categoryTitle;
    data['pdf'] = pdf;
    return data;
  }
}
