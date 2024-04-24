class ContentModel {
  List<Post>? post;

  ContentModel({this.post});

  ContentModel.fromJson(Map<String, dynamic> json) {
    if (json['post'] != null) {
      post = <Post>[];
      json['post'].forEach((v) {
        post!.add(Post.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (post != null) {
      data['post'] = post!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Post {
  int? id;
  int? categoryId;
  String? title;
  String? img;
  int? dateTime;
  String? content;
  String? slug;

  Post(
      {this.id,
      this.categoryId,
      this.title,
      this.img,
      this.dateTime,
      this.content,
      this.slug});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    img = json['img'];
    dateTime = json['date_time'];
    content = json['content'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['title'] = title;
    data['img'] = img;
    data['date_time'] = dateTime;
    data['content'] = content;
    data['slug'] = slug;
    return data;
  }
}
