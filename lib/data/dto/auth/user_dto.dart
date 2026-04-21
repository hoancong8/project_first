import 'dart:ffi';

class UserDto {
  final String id;
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
      id: json["data"]['id'],
      name: json["data"]['firstName'],
      email: json["data"]['email'],
      avtUrl: json["data"]['avatarUrl'],
      isOnline: json["data"]['IsActive'] == 1 ? true : false,
      timeLogin: json["data"]['phoneNumber'],
    );
  }
}
