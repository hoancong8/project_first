import 'dart:ffi';

class UserDto {
  final String id;
  final String? name;
  final String? email;
  final String? avtUrl;
  final bool? isOnline;
  final String? timeLogin;
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
      id: json['id']?.toString() ?? '',
      name: (json['fullName'] ?? json['firstName'] ?? json['name'])?.toString(),
      email: json['email']?.toString(), // Dùng toString() và nullable
      avtUrl: json['avatarUrl']?.toString(),
      isOnline: json['IsActive'] == 1,
      timeLogin: (json['phoneNumber'] ?? json['timeLogin'])?.toString(), // Tránh bị null
    );
  }
}
