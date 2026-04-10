import 'package:project_first/data/dto/auth/auth_dto.dart';

abstract class AuthRemoteDataSource{
  Future<AuthDto> login(String username, String password);
  Future<String> register(String username, String password,String name);
}