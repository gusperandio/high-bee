class UserModel {
  String? id;  
  String? name;
  String? age;
  String? country;
  String? intention;
  String? avatar;
  bool? isRegistered;
  bool? termsAgree;
  bool? premium;
  List<String>? news;
  List<dynamic>? stickers;
  List<dynamic>? publicity;
  List<String>? reports;
  List<dynamic>? reportPublicity;
  List<dynamic>? competition;
  String? premiumTime;
  String? role;
  String? createdAt;

  UserModel({
    this.id, 
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
    this.reports,
    this.reportPublicity,
    this.competition,
    this.premiumTime,
    this.role,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      country: map['country'] ?? '',
      intention: map['intention'] ?? '',
      avatar: map['avatar'] ?? '',
      isRegistered: map['isRegistered'] ?? false,
      termsAgree: map['termsAgree'] ?? false,
      premium: map['premium'] ?? false,
      news: List<String>.from(map['news'] ?? []),
      stickers: List<dynamic>.from(map['stickers'] ?? []),
      publicity: List<dynamic>.from(map['publicity'] ?? []),
      reports: List<String>.from(map['news'] ?? []),
      reportPublicity: List<dynamic>.from(map['reportPublicity'] ?? []),
      competition: List<dynamic>.from(map['competition'] ?? []),
      premiumTime: map['premiumTime'] ?? '',
      role: map['role'] ?? 'user',
      createdAt: map['createdAt'] ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,  
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
      'reports': reports ?? [],
      'reportPublicity': reportPublicity ?? [],
      'competition': competition ?? [],
      'premiumTime': premiumTime,
      'role': role,
      'createdAt': createdAt,
    };
  }
}
