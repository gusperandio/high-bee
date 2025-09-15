import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:high_bee/docs/singletons/user_singleton.dart'; 
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository.g.dart';

@riverpod
UserRepository userRepository(Ref ref) {
  return UserRepository();
}

@Riverpod()
UserRepository userRepositoryCache(Ref ref) {
  return UserRepository.cache();
}

class UserRepository implements RepositoryAsyncInterface<User, User> {
  RepositoryType type = RepositoryType.singleton;

  UserRepository({this.type = RepositoryType.singleton});
  UserRepository.cache({this.type = RepositoryType.cache});

  @override
  Future<void> add(User user) async {
    if (type == RepositoryType.cache) {
      await Cache.set<User>('UserRepository', user);
      return;
    }

    final userData = UserSingleton.instance;
    userData.name = user.name ?? userData.name;
    userData.birthDate = user.birthDate ?? userData.birthDate;
    userData.cpf = user.cpf ?? userData.cpf;
    userData.agentCode = user.agentCode ?? userData.agentCode;
    userData.gender = user.gender ?? userData.gender;
    userData.email = user.email ?? userData.email;
    userData.phone = user.phone ?? userData.phone;
    userData.zipCode = user.zipCode ?? userData.zipCode;
    userData.address = user.address ?? userData.address;
  }

  @override
  Future<void> addAll(User user) async {
    if (type == RepositoryType.cache) {
      await Cache.set<User>('UserRepository', user);
      return;
    }

    final userData = UserSingleton.instance;
    userData.name = user.name ?? userData.name;
    userData.birthDate = user.birthDate ?? userData.birthDate;
    userData.cpf = user.cpf ?? userData.cpf;
    userData.agentCode = user.agentCode ?? userData.agentCode;
    userData.gender = user.gender ?? userData.gender;
    userData.email = user.email ?? userData.email;
    userData.phone = user.phone ?? userData.phone;
    userData.zipCode = user.zipCode ?? userData.zipCode;
    userData.address = user.address ?? userData.address;
  }

  @override
  Future<void> clear() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteById(int id) {
    throw UnimplementedError();
  }

  @override
  Future<User> getAll() async {
    if (type == RepositoryType.cache) {
      final user = await Cache.get<User>('UserRepository', fromJson: User.fromJson);
      if (user != null) return user; // Informações em cache

      final userServices = UserServices();
      final userResponseData = await userServices.get();
      await add(userResponseData);
      return userResponseData;
    }

    final userData = UserSingleton.instance; // Informações em singleton
    return User(
      name: userData.name,
      birthDate: userData.birthDate,
      cpf: userData.cpf,
      agentCode: userData.agentCode,
      gender: userData.gender,
      email: userData.email,
      phone: userData.phone,
      zipCode: userData.zipCode,
      address: userData.address,
    );
  }

  @override
  Future<User?> getById(int id) {
    throw UnimplementedError();
  }

  @override
  Future<bool> isEmpty() {
    throw UnimplementedError();
  }

  @override
  Future<void> update(User data) {
    throw UnimplementedError();
  }
}
