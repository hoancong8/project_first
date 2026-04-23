import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_first/data/datasource/remote/abstract/profile_remote_datasource.dart';
import 'package:project_first/data/dto/auth/user_dto.dart';

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource{
  final Dio _dio;
  ProfileRemoteDatasourceImpl(this._dio);
  @override
  Future<UserDto> getProfile() async {
    try {
      final response = await _dio.get('/api/auth/profile');

      return UserDto.fromJson(response.data['data']);
    } catch (e) {
      debugPrint("GET PROFILE ${e.toString()}");
      rethrow;
    }
  }

}