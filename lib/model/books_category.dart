class BooksCategory {
  List<Data> data;

  BooksCategory({this.data});

  BooksCategory.fromJson(Map<String, dynamic> json) {
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
  int bookId;
  String bookName;
  String bookLink;

  Data({this.bookId, this.bookName, this.bookLink});

  Data.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    bookName = json['book_name'];
    bookLink = json['book_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.bookId;
    data['book_name'] = this.bookName;
    data['book_link'] = this.bookLink;
    return data;
  }
}
