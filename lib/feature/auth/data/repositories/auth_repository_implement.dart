import 'package:gitty/feature/auth/data/data_source/auth_service.dart';
import 'package:gitty/feature/auth/domain/entities/user_entity.dart';
import 'package:gitty/feature/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;
  AuthRepositoryImpl({required this.authService});

  @override
  Future<UserEntity?> loginUser({required String email}) async {
    return await authService.loginUser(email: email);
  }

  @override
  Future<UserEntity?> registerUser({
    required String email,
    required String password,
  }) async {
    return await authService.registerUser(
      email: email,
      password: password,
    );
  }
}
