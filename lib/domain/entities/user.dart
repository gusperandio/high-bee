import 'package:intl/intl.dart';
import 'package:high_bee/domain/valueObjects/cpf.dart';
import 'package:high_bee/domain/valueObjects/email.dart';
import 'package:high_bee/domain/valueObjects/gender.dart';
import 'package:high_bee/domain/valueObjects/phone.dart';
import 'package:high_bee/domain/valueObjects/zip_code.dart';
import 'package:high_bee/domain/entities/user_address.dart';

class User {
  String? name = '';
  DateTime? birthDate;
  CPF? cpf = CPF.empty();
  int? agentCode = 0;
  Gender? gender = Gender(GenderEnum.empty);
  Email? email = Email.empty();
  Phone? phone = Phone.empty();
  ZipCode? zipCode = ZipCode.empty();
  UserAddress? address = UserAddress.empty();

  User({
    this.name,
    this.birthDate,
    this.cpf,
    this.agentCode,
    this.gender,
    this.email,
    this.phone,
    this.zipCode,
    this.address,
  });

  User.initial()
    : name = '',
      birthDate = null,
      cpf = CPF.empty(),
      agentCode = 0,
      gender = Gender(GenderEnum.empty),
      email = Email.empty(),
      phone = Phone.empty(),
      zipCode = ZipCode.empty(),
      address = UserAddress.empty();

  User.fromJson(Map<String, dynamic> json)
    : name = json['name'] as String?,
      birthDate =
          json['birthDate'] != null
              ? DateTime.parse(json['birthDate'])
              : json['data_nascimento'] != null
              ? DateTime.parse(json['data_nascimento'])
              : null,
      cpf =
          json['cpf'] != null
              ? CPF(json['cpf'])
              : json['num_doc'] != null
              ? CPF(json['num_doc'])
              : CPF.empty(),
      agentCode =
          json['agentCode'] != null
              ? json['agentCode'] as int?
              : json['cod_agente'] != null
              ? json['cod_agente'] as int?
              : null,
      gender =
          json['gender'] != null
              ? Gender.fromString(json['gender'])
              : json['sex'] == Gender(GenderEnum.empty)
              ? null
              : json['sex'] == 'M'
              ? Gender(GenderEnum.masculino)
              : Gender(GenderEnum.feminino),
      email = json['email'] != null ? Email(json['email']) : Email.empty(),
      phone =
          json['phone'] != null
              ? Phone(json['phone'])
              : json['celular'] != null
              ? Phone(json['celular'])
              : Phone.empty(),
      zipCode =
          json['zipCode'] != null
              ? ZipCode(json['zipCode'])
              : json['cep'] != null
              ? ZipCode(json['cep'])
              : ZipCode.empty(),
      address =
          json['address'] != null &&
                  json['address'].runtimeType.toString() ==
                      '_Map<String, dynamic>'
              ? UserAddress.fromJson(json['address'])
              : json['address'] != null &&
                  json['address'].runtimeType.toString() == 'String'
              ? UserAddress(
                city: json['city'],
                state: json['state'],
                street: json['address'],
                neighborhood: json['neighborhood'],
                number: json['number'],
                complement: json['complement'],
              )
              : UserAddress.empty();

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email?.value,
    'data_nascimento': birthDate?.toIso8601String(),
    'cpf': cpf?.value,
    'agentCode': agentCode,
    'gender': gender?.value.name,
    'phone': phone?.value,
    'zipCode': zipCode?.value,
    'address': address?.toJson(),
    'tipopessoa': 'F',
  };

  Map<String, dynamic> toJsonUpdate() => {
    'nome': name,
    'email': email?.value,
    'data_nascimento': DateFormat('yyyy-MM-dd HH:mm:ss').format(birthDate!),
    'cpf': cpf?.toString(),
    'sex': gender?.displayName,
    'celular': phone?.value,
    'cep': zipCode?.mask,
    'address': address?.street,
    'complement': null,
    'number': address?.number,
    'neighborhood': null,
    'city': address?.city,
    'state': address?.state,
    'tipopessoa': 'F',
  };
}
