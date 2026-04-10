import 'package:project_first/data/dto/auth/user_dto.dart';

class AuthDto {
  final String token;
  AuthDto({required this.token});

  factory AuthDto.fromJson(Map<String, dynamic> json) {
    return AuthDto(
      token: json['token']
    );
  }
}
