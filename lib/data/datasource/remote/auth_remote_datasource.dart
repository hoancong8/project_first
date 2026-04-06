import 'package:dio/dio.dart';
import '../../dto/auth/auth_dto.dart';

class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  Future<AuthDto> login(String username, String password) async {
    try {
      final response = await _dio.post('/api/auth/login', data: {
        'email': username,
        'password': password,
      });
      
      return AuthDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
  Future<String> register(String username, String password,String name) async {
    try {
      final response = await _dio.post('/api/auth/register', data: {
        'email': username,
        'password': password,
        'name': name,
      });
      return response.data['message'];
    } catch (e) {
      rethrow;
    }
  }

}
