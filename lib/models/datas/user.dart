class UserModel {
  String? id; // Added id field
  String? name;
  String? age;
  String? country;
  String? intention;
  String? avatar;
  bool? isRegistered;
  bool? termsAgree;
  bool? premium;
  List<dynamic>? news;
  List<dynamic>? stickers;
  List<dynamic>? publicity;
  List<dynamic>? reportNews;
  List<dynamic>? reportPublicity;
  List<dynamic>? competition;
  String? premiumTime;
  String? role;

  UserModel({
    this.id, // Added id to the constructor
    this.name,
    this.age,
    this.country,
    this.intention,
    this.avatar,
    this.isRegistered,
    this.termsAgree,
    this.premium,
    this.news,
    this.stickers,
    this.publicity,
    this.reportNews,
    this.reportPublicity,
    this.competition,
    this.premiumTime,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'], // Added id to fromJson
      name: map['name'],
      age: map['age'],
      country: map['country'],
      intention: map['intention'],
      avatar: map['avatar'],
      isRegistered: map['isRegistered'],
      termsAgree: map['termsAgree'],
      premium: map['premium'],
      news: List<dynamic>.from(map['news'] ?? []),
      stickers: List<dynamic>.from(map['stickers'] ?? []),
      publicity: List<dynamic>.from(map['publicity'] ?? []),
      reportNews: List<dynamic>.from(map['reportNews'] ?? []),
      reportPublicity: List<dynamic>.from(map['reportPublicity'] ?? []),
      competition: List<dynamic>.from(map['competition'] ?? []),
      premiumTime: map['premiumTime'],
      role: map['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // Added id to toJson
      'name': name,
      'age': age,
      'country': country,
      'intention': intention,
      'avatar': avatar,
      'isRegistered': isRegistered,
      'termsAgree': termsAgree,
      'premium': premium,
      'news': news ?? [],
      'stickers': stickers ?? [],
      'publicity': publicity ?? [],
      'reportNews': reportNews ?? [],
      'reportPublicity': reportPublicity ?? [],
      'competition': competition ?? [],
      'premiumTime': premiumTime,
      'role': role,
    };
  }
}
