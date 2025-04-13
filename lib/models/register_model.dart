class Register {
  String name;
  String email;
  String password;
  String age;
  String nationality;
  String intention;

  Register({
    required this.name,
    required this.email,
    required this.password,
    required this.age,
    required this.nationality,
    required this.intention,
  });

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      age: json['age'],
      nationality: json['nationality'],
      intention: json['intention'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'age': age,
      'nationality': nationality,
      'intention': intention,
    };
  }
}