import 'package:project_first/data/dto/auth/user_dto.dart';

abstract class ProfileRemoteDatasource{
  Future<UserDto> getProfile();
}