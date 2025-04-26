import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:high_bee/models/datas/user.dart';
import 'package:high_bee/services/auth/auth_service.dart';

class UserService {
  static final UserService _instance = UserService._internal();

  factory UserService() {
    return _instance;
  }

  UserService._internal();

  final _db = FirebaseDatabase.instance;

  String? get userId => AuthService().getCurrentUIDUser();

  Future<bool> isUserRegistered() async {
    if (userId == null) return false;

    final snapshot = await _db.ref('users/$userId/isRegistered').get();
    if (snapshot.exists) {
      return snapshot.value as bool;
    }
    return false;
  }

  Future<UserModel?> getUserDatas() async {
    if (userId == null) return null;
    final snapshot = await _db.ref('users/$userId').get();
    if (snapshot.exists && snapshot.value is Map) {
      return UserModel.fromJson(
        Map<String, dynamic>.from(snapshot.value as Map),
      );
    }
    return null;
  }

  Future<void> saveUserRegistes(UserModel user) async {
    if (userId == null) return;

    await _db.ref('users/$userId').set({
      'name': user.name,
      'age': user.age,
      'country': user.country,
      'intention': user.intention,
      'avatar': user.avatar,
      'isRegistered': true,
      'termsAgree': true,
      'premium': false,
      'news': [],
      'stickers': [],
      'publicity': [],
      'reportNews': [],
      'reportPublicity': [],
      'competition': [],
      'premiumTime': '',
      'role': 'USER',
    });
  }
}
