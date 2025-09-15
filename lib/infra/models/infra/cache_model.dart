class CacheModel {
  final String id;
  final String value;
  final DateTime exp;
  final String? tag;

  CacheModel({
    required this.id,
    required this.value,
    required this.exp,
    this.tag,
  });

  Map<String, Object?> toMap() {
    return {'id': id, 'value': value, 'exp': exp.toIso8601String(), 'tag': tag};
  }

  @override
  String toString() {
    return 'Cache{id: $id, value: $value, exp: $exp, tag: $tag}';
  }
}
