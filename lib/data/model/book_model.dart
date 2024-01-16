class BookData {
  List<String>? audio;
  String? author;
  String? book;
  String? category;
  String? id;
  String? img;
  String? title;

  BookData(
      {this.audio,
        this.author,
        this.book,
        this.category,
        this.id,
        this.img,
        this.title});

  BookData.fromJson(Map<String, dynamic> json) {
    audio = json['audio'].cast<String>();
    author = json['author'];
    book = json['book'];
    category = json['category'];
    id = json['id'];
    img = json['img'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['audio'] = audio;
    data['author'] = author;
    data['book'] = book;
    data['category'] = category;
    data['id'] = id;
    data['img'] = img;
    data['title'] = title;
    return data;
  }
}
