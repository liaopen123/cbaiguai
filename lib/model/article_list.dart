class ArticleList {
  List<Data> data;

  ArticleList({this.data});

  ArticleList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int articleId;
  String articleTitle;
  String articleDes;
  String articleLink;

  Data({this.articleId, this.articleTitle, this.articleDes, this.articleLink});

  Data.fromJson(Map<String, dynamic> json) {
    articleId = json['article_id'];
    articleTitle = json['article_title'];
    articleDes = json['article_des'];
    articleLink = json['article_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['article_id'] = this.articleId;
    data['article_title'] = this.articleTitle;
    data['article_des'] = this.articleDes;
    data['article_link'] = this.articleLink;
    return data;
  }
}
