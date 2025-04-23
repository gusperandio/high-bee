class UserModel {
  final String? id;
  final String? name;
  final String? age;
  final String? country;
  final String? intention;
  final String? avatar;
  final bool? termsAgree;

  UserModel({
    this.id,
    this.name,
    this.age,
    this.country,
    this.intention,
    this.avatar,
    this.termsAgree,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      age: json['age'] as String? ?? '',
      country: json['country'] as String? ?? '',
      intention: json['intention'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      termsAgree: json['termsAgree'] as bool? ?? false,
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
      'termsAgree': termsAgree,
    };
  }
}
