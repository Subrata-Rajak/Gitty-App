import 'package:gitty/feature/auth/domain/entities/user_entity.dart';
import 'package:gitty/feature/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  Future<UserEntity?> loginUser({required String email}) async {
    return await authRepository.loginUser(email: email);
  }
}
