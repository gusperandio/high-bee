import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/infra/models/datas/user.dart';
import 'package:high_bee/services/auth/auth_service.dart';
import 'package:high_bee/util/cache.dart';
import 'package:intl/intl.dart';

class ValidationViewModel extends ChangeNotifier {
  final controller = BoardDateTimeController();
  final dateFormat = DateFormat('dd/MM/yyyy');
  final now = DateTime.now();

  String? errorMessage;
  DateTime? _age;
  String? _country;
  String? _intention;

  bool isAdult = false;
  Color alertAge = PrimaryColors.carvaoColor;

  DateTime? get age => _age;
  set age(DateTime? value) {
    _age = value;
    _updateAgeValidation(value);
  }

  String? get country => _country;
  set country(String? value) {
    _country = value;
    notifyListeners();
  }

  String? get intention => _intention;
  set intention(String? value) {
    _intention = value;
    notifyListeners();
  }

  bool get isComplete =>
      _country != null && _intention != null && _age != null && isAdult;

  final List<Map<String, String>> southAmericanCountries = [
    {'country': 'Argentina', 'flag': 'assets/svg/flags/flag-ar.svg'},
    {'country': 'Brasil', 'flag': 'assets/svg/flags/flag-br.svg'},
    {'country': 'Chile', 'flag': 'assets/svg/flags/flag-cl.svg'},
    {'country': 'Colômbia', 'flag': 'assets/svg/flags/flag-co.svg'},
    {'country': 'Equador', 'flag': 'assets/svg/flags/flag-ec.svg'},
    {'country': 'Paraguai', 'flag': 'assets/svg/flags/flag-py.svg'},
    {'country': 'Peru', 'flag': 'assets/svg/flags/flag-pe.svg'},
    {'country': 'Uruguai', 'flag': 'assets/svg/flags/flag-uy.svg'},
  ];

  final List<Map<String, String>> cannabisIntentions = [
    {'area': 'Saúde - Médico(a)'},
    {'area': 'Saúde - Dentista'},
    {'area': 'Saúde - Psicólogo(a)'},
    {'area': 'Saúde - Enfermeiro(a)'},
    {'area': 'Saúde - Terapeuta holístico'},
    {'area': 'Direito - Advogado(a)'},
    {'area': 'Direito - Consultor jurídico'},
    {'area': 'Educação - Pesquisador(a)'},
    {'area': 'Educação - Professor(a)'},
    {'area': 'Educação - Estudante'},
    {'area': 'Tecnologia - Desenvolvedor(a) de software'},
    {'area': 'Tecnologia - Engenheiro(a) de hardware'},
    {'area': 'Tecnologia - Cientista de dados'},
    {'area': 'Empreendedorismo - Cultivador(a)'},
    {'area': 'Empreendedorismo - Fabricante de produtos'},
    {'area': 'Empreendedorismo - Distribuidor(a)'},
    {'area': 'Empreendedorismo - Dono(a) de growshop/headshop'},
    {'area': 'Empreendedorismo - Criador de conteúdo'},
    {'area': 'Indústria - Cosméticos com cannabis'},
    {'area': 'Indústria - Alimentos com cannabis'},
    {'area': 'Indústria - Bebidas infusionadas'},
    {'area': 'Indústria - Produtos veterinários'},
    {'area': 'Bem-estar - Yoga e meditação com cannabis'},
    {'area': 'Bem-estar - Aromaterapia'},
    {'area': 'Bem-estar - Fitoterapia'},
    {'area': 'Agronegócio - Pesquisa genética de sementes'},
    {'area': 'Agronegócio - Automatização de cultivo'},
    {'area': 'Sustentabilidade - Bioenergia a partir do cânhamo'},
    {'area': 'Sustentabilidade - Bioconstrução com cânhamo'},
    {'area': 'Moda - Confecção com tecidos de cânhamo'},
    {'area': 'Arte e Cultura - Artista visual'},
    {'area': 'Arte e Cultura - Músico(a)'},
    {'area': 'Arte e Cultura - Produtor(a) cultural'},
    {'area': 'Ativismo - Redução de danos'},
    {'area': 'Ativismo - Direitos humanos'},
    {'area': 'Ativismo - Educação canábica'},
    {'area': 'Marketing - Publicidade no setor canábico'},
    {'area': 'Marketing - Influenciador(a) digital'},
    {'area': 'Outros - Curioso(a) sobre o tema'},
    {'area': 'Outros - Usuário(a) medicinal'},
    {'area': 'Outros - Usuário(a) recreativo consciente'},
  ];

  void _updateAgeValidation(DateTime? value) {
    if (value == null) return;

    isAdult = _isOver18(value);
    if (isAdult) {
      errorMessage = null;
      alertAge = PrimaryColors.carvaoColor;
    } else {
      errorMessage = "Acesso negado. Você precisa ter pelo menos 18 anos.";
      alertAge = SecondaryColors.danger;
    }
    notifyListeners();
  }

  bool _isOver18(DateTime date) {
    final today = DateTime.now();
    final age =
        today.year -
        date.year -
        ((today.month < date.month ||
                (today.month == date.month && today.day < date.day))
            ? 1
            : 0);
    return age >= 18;
  }

  Future<void> saveDatas() async {
    await Cache().setUser(
      UserModel(
        id: AuthService().getCurrentUIDUser(),
        age: dateFormat.format(_age!),
        country: _country!,
        intention: _intention!,
      ),
    );
  }
}
