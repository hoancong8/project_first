import 'package:project_first/data/dto/auth/user_dto.dart';

class AuthDto {
  final String token;

  final UserDto user;
  AuthDto({required this.token, required this.user});

  factory AuthDto.fromJson(Map<String, dynamic> json) {
    return AuthDto(
      token: json['token'],
      user: UserDto.fromJson(json['user']),
    );
  }
}
