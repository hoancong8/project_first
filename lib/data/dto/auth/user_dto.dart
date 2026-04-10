import 'dart:ffi';

class UserDto {
  final int id;
  final String? name;
  final String email;
  final String? avtUrl;
  final bool isOnline;
  final String timeLogin;
  UserDto({
    required this.email,
    required this.id,
    required this.name,
    required this.avtUrl,
    required this.isOnline,
    required this.timeLogin,
  });
  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avtUrl: json['avatar_url'],
      isOnline: json['is_onl'] == 1 ? true : false,
      timeLogin: json['time_login'],
    );
  }
}
