class NewsModel {
  String? id;
  String? title;
  String? argument;
  String? tag;
  UserNews? user;
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
  String font;  

  NewsModel({
    this.id,
    this.title,
    this.argument,
    this.tag,
    this.user,
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
      'user': user?.toJson(),
      'minReads': minReads,
      'aiValidate': aiValidate,
      'cape': cape,
      'photo1': photo1,
      'photo1desc': photo1desc,
      'photo2': photo2,
      'photo2desc': photo2desc,
      'photo3': photo3,
      'photo3desc': photo3desc,
      'likes': likes, 
      'font': font,  
    };
  }

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      argument: json['argument'] ?? "",
      tag: json['tag'] ?? "",
      user:
          json['user'] != null
              ? UserNews.fromJson(Map<String, dynamic>.from(json['user']))
              : UserNews(name: "", intention: "", userId: ""),
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

  NewsModel copyWith({
    String? id,
    String? title,
    String? argument,
    String? tag,
    UserNews? user,
    int? minReads,
    bool? aiValidate,
    String? cape,
    String? photo1,
    String? photo1desc,
    String? photo2,
    String? photo2desc,
    String? photo3,
    String? photo3desc,
    int? likes,
    String? font,
  }) {
    return NewsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      argument: argument ?? this.argument,
      tag: tag ?? this.tag,
      minReads: minReads ?? this.minReads,
      aiValidate: aiValidate ?? this.aiValidate,
      cape: cape ?? this.cape,
      photo1: photo1 ?? this.photo1,
      photo1desc: photo1desc ?? this.photo1desc,
      photo2: photo2 ?? this.photo2,
      photo2desc: photo2desc ?? this.photo2desc,
      photo3: photo3 ?? this.photo3,
      photo3desc: photo3desc ?? this.photo3desc,
      likes: likes ?? this.likes,
      font: font ?? this.font,
    );
  }
}

class UserNews {
  String userId;
  String name;
  String intention;

  UserNews({required this.userId, required this.name, required this.intention});

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'name': name, 'intention': intention};
  }

  factory UserNews.fromJson(Map<String, dynamic> json) {
    return UserNews(
      userId: json['userId'] ?? "",
      name: json['name'] ?? "",
      intention: json['intention'] ?? "",
    );
  }
}
