import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier{
  String _name = "Gustavo Sperandio ";

  String get name => _name;

  void setName(String value) {
    _name = value;
  }
}