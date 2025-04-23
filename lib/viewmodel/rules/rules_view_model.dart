import 'package:flutter/material.dart';
import 'package:high_bee/models/datas/user.dart';

class RulesViewModel extends ChangeNotifier {
  late final UserModel dados;
  final List<Map<String, dynamic>> agreeRules = [
    {
      'rule':
          "Compartilhar informações educacionais sobre cannabis, CBD e cânhamo, desde que sejam baseadas em estudos científicos ou regulamentações oficiais.",
      'ruleValid': true,
    },
    {
      'rule':
          "Relatar experiências pessoais sobre o uso de produtos com CBD ou cânhamo, desde que não façam alegações terapêuticas ou promessas de cura.",
      'ruleValid': true,
    },
    {
      'rule':
          "Divulgar produtos que sejam legalmente autorizados pela Anvisa, como produtos à base de cannabis registrados e regulamentados para uso medicinal.",
      'ruleValid': true,
    },
    {
      'rule':
          "Participar de discussões sobre o cultivo de cânhamo industrial, desde que seja para fins permitidos pela legislação (ex.: produção de fibras, alimentos ou cosméticos não medicinais).",
      'ruleValid': true,
    },
  ];

  final List<Map<String, dynamic>> disagreeRules = [
    {
      'rule':
          "Fazer propaganda ou venda de produtos derivados de cannabis que não estejam devidamente registrados ou autorizados pela Anvisa.",
      'ruleValid': false,
    },
    {
      'rule':
          "Divulgar tratamentos ou curas milagrosas que envolvem o uso de cannabis ou CBD.",
      'ruleValid': false,
    },
    {
      'rule':
          "Oferecer instruções sobre o cultivo doméstico de cannabis para uso pessoal ou recreativo.",
      'ruleValid': false,
    },
    {
      'rule':
          "Promover produtos ou métodos de uso que sejam proibidos pela legislação brasileira.",
      'ruleValid': false,
    },
    {
      'rule':
          "Divulgar conteúdos que incentivem o uso recreativo de cannabis, especialmente para menores de idade.",
      'ruleValid': false,
    },
    {
      'rule':
          "Publicar informações falsas ou enganosas sobre os efeitos da cannabis, CBD ou cânhamo.",
      'ruleValid': false,
    },
  ];
}
