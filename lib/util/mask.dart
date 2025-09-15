import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum MaskType {
  altura,
  cartao,
  centavos,
  cep,
  cpf,
  cnpj,
  cest,
  cns,
  data,
  hora,
  iof,
  km,
  certNascimento,
  peso,
  placa,
  real,
  telefone,
  validadeCartao,
  temperatura,
  nmr,
}

Map<String, RegExp>? filter = {"#": RegExp(r'[0-9]')};

var maskFormatters = {
  MaskType.altura: MaskTextInputFormatter(mask: '#,##', filter: filter),
  MaskType.cartao: MaskTextInputFormatter(mask: '#### #### #### #### ####', filter: filter),
  MaskType.centavos: MaskTextInputFormatter(mask: '#,###', filter: filter),
  MaskType.cep: MaskTextInputFormatter(mask: '##.###-###', filter: filter),
  MaskType.cpf: MaskTextInputFormatter(mask: '###.###.###-##', filter: filter),
  MaskType.cnpj: MaskTextInputFormatter(mask: '##.###.###/####-##', filter: filter),
  MaskType.data: MaskTextInputFormatter(mask: '##/##/####', filter: filter),
  MaskType.hora: MaskTextInputFormatter(mask: '##:##', filter: filter),
  MaskType.iof: MaskTextInputFormatter(mask: '#,######', filter: filter),
  MaskType.km: MaskTextInputFormatter(mask: '###.###', filter: filter),
  MaskType.certNascimento: MaskTextInputFormatter(mask: '###### ## ## #### # ##### ### ####### ##', filter: filter),
  MaskType.peso: MaskTextInputFormatter(mask: '###,#', filter: filter),
  MaskType.placa: MaskTextInputFormatter(mask: '###-####', filter: filter),
  MaskType.real: MaskTextInputFormatter(mask: '##.###', filter: filter),
  MaskType.telefone: MaskTextInputFormatter(mask: '(##) #####-####', filter: filter),
  MaskType.validadeCartao: MaskTextInputFormatter(mask: '##/##', filter: filter),
  MaskType.temperatura: MaskTextInputFormatter(mask: '##,#', filter: filter),
  MaskType.nmr: MaskTextInputFormatter(mask: '#####', filter: filter),
};

MaskTextInputFormatter getMask(MaskType? maskType) {
  return maskFormatters[maskType]!;
}
