class StickerModel {
  final String id;
  final String image;
  final String description;

  StickerModel({
    required this.id,
    required this.image,
    required this.description,
  });

  factory StickerModel.fromJson(Map<String, dynamic> json) {
    return StickerModel(
      id: json['id'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'image': image, 'description': description};
  }
}
