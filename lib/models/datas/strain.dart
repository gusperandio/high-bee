class StrainModel {
  final String nome;
  final String desc;
  final double thc;
  final List<String> combinacao;
  final int rendIndoor;
  final int rendOutdoor;
  final List<String> efeitos;
  final String photo;
  final bool hibrida;
  final bool sativa;
  final bool indica;
  final bool fotoperiodo;
  final bool automatica;

  StrainModel({
    required this.nome,
    required this.desc,
    required this.thc,
    required this.combinacao,
    required this.rendIndoor,
    required this.rendOutdoor,
    required this.efeitos,
    required this.photo,
    required this.hibrida,
    required this.sativa,
    required this.indica,
    required this.fotoperiodo,
    required this.automatica,
  });
 
  factory StrainModel.fromJson(Map<String, dynamic> json) {
    return StrainModel(
      nome: json['nome'],
      desc: json['desc'],
      thc: json['thc'].toDouble(),
      combinacao: List<String>.from(json['combinacao']),
      rendIndoor: json['rendIndoor'],
      rendOutdoor: json['rendOutdoor'],
      efeitos: List<String>.from(json['efeitos']),
      photo: json['photo'],
      hibrida: json['hibrida'],
      sativa: json['sativa'],
      indica: json['indica'],
      fotoperiodo: json['fotoperiodo'],
      automatica: json['automatica'],
    );
  }
 
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'desc': desc,
      'thc': thc,
      'combinacao': combinacao,
      'rendIndoor': rendIndoor,
      'rendOutdoor': rendOutdoor,
      'efeitos': efeitos,
      'photo': photo,
      'hibrida': hibrida,
      'sativa': sativa,
      'indica': indica,
      'fotoperiodo': fotoperiodo,
      'automatica': automatica,
    };
  }
}
