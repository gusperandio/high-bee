class SubscribeModel {
  final String idUser;
  final String image;

  SubscribeModel({
    required this.idUser,
    required this.image,
  });

  factory SubscribeModel.fromJson(Map<String, dynamic> json) {
    return SubscribeModel(
      idUser: json['idUser'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'image': image,
    };
  }
}