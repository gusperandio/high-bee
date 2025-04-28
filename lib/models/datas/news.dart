class NewsModel {
  String? id;
  String? title;
  String? argument;
  String? tag;
  String? userId;
  int? minReads;
  bool? aiValidate;
  String? cape;
  String? photo1;
  String? photo1desc;
  String? photo2;
  String? photo2desc;
  String? photo3;
  String? photo3desc;
  int likes;
  String font; // New attribute

  NewsModel({
    this.id,
    this.title,
    this.argument,
    this.tag,
    this.userId,
    this.minReads,
    this.aiValidate = false,
    this.cape,
    this.photo1,
    this.photo1desc,
    this.photo2,
    this.photo2desc,
    this.photo3,
    this.photo3desc,
    this.likes = 0,
    this.font = 'Georgia',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'argument': argument,
      'tag': tag,
      'userId': userId,
      'minReads': minReads,
      'aiValidate': aiValidate,
      'cape': cape,
      'photo1': photo1,
      'photo1desc': photo1desc,
      'photo2': photo2,
      'photo2desc': photo2desc,
      'photo3': photo3,
      'photo3desc': photo3desc,
      'likes': likes, // Include likes in toJson
      'font': font, // Include font in toJson
    };
  }

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      argument: json['argument'] ?? "",
      tag: json['tag'] ?? "",
      userId: json['userId'] ?? "",
      minReads: json['minReads'] ?? 0,
      aiValidate: json['aiValidate'] ?? false,
      cape: json['cape'] ?? "",
      photo1: json['photo1'] ?? "",
      photo1desc: json['photo1desc'] ?? "",
      photo2: json['photo2'] ?? "",
      photo2desc: json['photo2desc'] ?? "",
      photo3: json['photo3'] ?? "",
      photo3desc: json['photo3desc'] ?? "",
      likes: json['likes'] ?? 0,
      font: json['font'] ?? "Georgia",
    );
  }
}
