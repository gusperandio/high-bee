import 'package:uuid/uuid.dart';

class Competition {
  final String id;
  final String name;
  final String description;
  final String image;
  final String expireDate;

  Competition({
    String? id,
    required this.name,
    required this.description,
    required this.image,
    required this.expireDate,
  }) : id = id ?? Uuid().v4();

  factory Competition.fromJson(Map<String, dynamic> json) {
    return Competition(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      expireDate: json['expireDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'expireDate': expireDate,
    };
  }
}
