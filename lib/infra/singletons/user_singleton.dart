import 'package:high_bee/domain/valueObjects/cpf.dart';
import 'package:high_bee/domain/valueObjects/email.dart';
import 'package:high_bee/domain/valueObjects/gender.dart';
import 'package:high_bee/domain/valueObjects/phone.dart';
import 'package:high_bee/domain/valueObjects/zip_code.dart';
import 'package:high_bee/domain/entities/user_address.dart';

class UserSingleton {
  String name = '';
  DateTime? birthDate;
  CPF cpf = CPF.empty();
  int agentCode = 0;
  Gender gender = Gender(GenderEnum.empty);
  Email email = Email.empty();
  Phone phone = Phone.empty();
  ZipCode zipCode = ZipCode.empty();
  UserAddress? address = UserAddress.empty();

  static final UserSingleton _instance = UserSingleton._privateConstructor();
  UserSingleton._privateConstructor();
  static UserSingleton get instance => _instance;
}
