import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../app/usecase.dart';
import '../../entities/auth_token.dart';
import '../../repositories/auth_repository.dart';

class LoginParams {
  final String username;
  final String password;
  LoginParams({required this.username, required this.password});
}

class LoginUseCase extends UseCase<AuthToken, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<AuthToken> call(LoginParams params) async {
    final token = await repository.login(params.username, params.password);
    final storage = FlutterSecureStorage();

    await storage.write(key: 'token', value: token.accessToken);
    return token;
  }
}
