import 'package:dio/dio.dart';
import 'package:project_first/data/datasource/remote/abstract/auth_remote_datasource.dart';
import '../../../dto/auth/auth_dto.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  final Dio _dio;
  AuthRemoteDataSourceImpl(this._dio);
  @override
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
  @override
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
