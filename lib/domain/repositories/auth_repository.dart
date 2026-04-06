import '../entities/auth_token.dart';

abstract class AuthRepository {
  Future<AuthToken> login(String username, String password);
  Future<String> register(String username, String password,String name);
}
