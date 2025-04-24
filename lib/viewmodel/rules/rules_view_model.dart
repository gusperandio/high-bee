import 'package:flutter/material.dart';
import 'package:high_bee/models/datas/user.dart';
import 'package:high_bee/util/cache.dart';

class RulesViewModel extends ChangeNotifier {
  late final UserModel dados;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  String _name = '';
  String? get name => _name;

  bool isChecked = false;
  bool acceptedPrivacy = false;
  bool acceptedTerms = false;
  bool warningTerms = false;
  bool warningPrivacy = false;
  String? errorMessage;
  bool isComplete = false;

  final List<Map<String, dynamic>> rules = [
    {
      'context': 'Info confiável é tudo',
      'phrase':
          'Pode compartilhar conteúdo sobre cannabis, CBD e cânhamo, mas sempre com base em estudos sérios ou nas regras da Anvisa. Nada de achismo por aqui.',
      'ruledValid': true,
    },
    {
      'context': 'Experiência real conta (com responsabilidade)',
      'phrase':
          'Relatos pessoais sobre o uso de CBD ou cânhamo são bem-vindos! Mas sem prometer cura ou milagre, beleza?',
      'ruledValid': true,
    },
    {
      'context': 'Produto liberado é produto seguro',
      'phrase':
          'Pode falar sobre produtos registrados na Anvisa, desde que não vire propaganda direta. Informação sim, venda agressiva não.',
      'ruledValid': true,
    },
    {
      'context': 'Cultivo de cânhamo? Só se for industrial',
      'phrase':
          'Falar sobre o cultivo pra produzir fibras, cosméticos ou alimentos não medicinais tá liberado. Só não vale incentivar cultivo caseiro pra uso próprio.',
      'ruledValid': true,
    },
    {
      'context': 'Tabacarias na área',
      'phrase':
          'É permitido divulgar acessórios como sedas, piteiras e trituradores.',
      'ruledValid': true,
    },
    {
      'context': 'Associações que apoiam o uso medicinal são bem-vindas',
      'phrase':
          'Pode divulgar entidades como a Apepi, que trabalham com educação e apoio sobre o tema.',
      'ruledValid': true,
    },
    {
      'context': 'Jardinagem liberada',
      'phrase':
          'Pode sim falar de sites que vendem produtos de cultivo — desde que não seja direto sobre cannabis recreativa.',
      'ruledValid': true,
    },
    {
      'context': 'Eventos e congressos oficiais? Pode divulgar!',
      'phrase': 'Desde que tenham autorização certinha.',
      'ruledValid': true,
    },
    {
      'context': 'Sistema colaborativo',
      'phrase':
          'Todos os posts passam por aprovação da comunidade. É tipo um filtro coletivo pra manter a vibe saudável.',
      'ruledValid': true,
    },
    {
      'context': 'Nada de propaganda de produtos não aprovados pela Anvisa',
      'phrase': 'Se não tem registro oficial, não rola divulgar.',
      'ruledValid': false,
    },
    {
      'context': 'Sem promessas milagrosas',
      'phrase':
          'Cannabis não é poção mágica. Falar que cura tudo ou qualquer exagero do tipo é proibido.',
      'ruledValid': false,
    },
    {
      'context': 'Cultivo em casa? Não! ',
      'phrase':
          'Ensinar ou incentivar cultivo doméstico pra uso pessoal/recreativo é vetado.',
      'ruledValid': false,
    },
    {
      'context': 'Produtos e métodos proibidos pela lei? Fora.',
      'phrase': 'Se não é legalizado, não tem espaço aqui.',
      'ruledValid': false,
    },
    {
      'context': 'Uso recreativo? Só que não ',
      'phrase':
          'Principalmente se for direcionado a menores de idade. Inclusive, o app é só pra maiores de 18.',
      'ruledValid': false,
    },
    {
      'context': 'Fake news aqui não! ',
      'phrase':
          'Não é permitido espalhar info falsa ou sem fonte sobre os efeitos da cannabis ou derivados.',
      'ruledValid': false,
    },
    {
      'context': 'Endereço de loja física? Pode parar.',
      'phrase': 'Nada de divulgar onde comprar pessoalmente.',
      'ruledValid': false,
    },
  ];

  void updateText(String newText) {
    _name = newText;
    notifyListeners();
  }

  void acceptPrivacy() {
    _updateAcceptance(privacy: true);
  }

  void acceptTerms() {
    _updateAcceptance(terms: true);
  }

  void checkBox(bool? value) {
    if (value != null) {
      isChecked = value;
      notifyListeners();
    }
  }

  void save() async {
    _resetWarnings();

    if (!isChecked) {
      errorMessage = "Você precisa concordar com as regras.";
    }

    if (!acceptedPrivacy || !acceptedTerms) {
      warningPrivacy = !acceptedPrivacy;
      warningTerms = !acceptedTerms;
      errorMessage = _buildErrorMessage();
    }

    if (formKey.currentState?.validate() == true &&
        isChecked &&
        acceptedPrivacy &&
        acceptedTerms) {
      isComplete = true;
      await _updateUserName();
    }

    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _updateAcceptance({bool? privacy, bool? terms}) {
    if (privacy != null) acceptedPrivacy = privacy;
    if (terms != null) acceptedTerms = terms;
    if (privacy == null && acceptedTerms) {
      warningTerms = false;
    }
    if (terms == null && acceptedPrivacy) {
      warningPrivacy = false;
    }
    notifyListeners();
  }

  void _resetWarnings() {
    warningPrivacy = false;
    warningTerms = false;
    errorMessage = null;
  }

  String? _buildErrorMessage() {
    if (!isChecked) {
      return "Você precisa concordar com as regras.";
    }
    return "Você precisa ler os documentos.";
  }

  Future<void> _updateUserName() async {
    UserModel? user = await Cache().getUser();
    if (user != null) {
      user.name = _name;
      await Cache().setUser(user);
    }
  }
}
