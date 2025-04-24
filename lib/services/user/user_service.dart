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

  String? get uid => AuthService().getCurrentUIDUser();

  Future<bool> isUserRegistered() async {
    final userId = uid;
    if (userId == null) return false;

    final snapshot = await _db.ref('users/$userId').get();
    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      return data['isRegistered'] == true;
    }
    return false;
  }

  Future<void> saveUserRegistes(UserModel user) async {
    final userId = uid;
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
