import 'package:gitty/feature/auth/domain/entities/user_entity.dart';
import 'package:gitty/feature/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository authRepository;

  RegisterUsecase({required this.authRepository});

  Future<UserEntity?> registerUser({
    required String email,
    required String password,
  }) async {
    return await authRepository.registerUser(
      email: email,
      password: password,
    );
  }
}
