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
}
