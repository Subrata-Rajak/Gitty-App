import 'package:gitty/feature/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> loginUser({required String email});
  Future<UserEntity?> registerUser(
      {required String email, required String password});
}
