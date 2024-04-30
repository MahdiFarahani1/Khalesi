class QuestionsModel {
  int? id;
  int? categoryId;
  String? title;
  String? content;
  String? answer;

  QuestionsModel(
      {this.id, this.categoryId, this.title, this.content, this.answer});

  QuestionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    content = json['content'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['answer'] = this.answer;
    return data;
  }
}
