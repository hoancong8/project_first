import 'package:project_first/data/dto/auth/user_dto.dart';

class AuthToken {
  final String accessToken;
  final UserDto user;
  AuthToken({required this.accessToken,required this.user});
}
