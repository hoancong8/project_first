import 'package:project_first/data/datasource/remote/abstract/profile_remote_datasource.dart';
import 'package:project_first/data/dto/auth/user_dto.dart';
import 'package:project_first/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository{
  final ProfileRemoteDatasource remoteDatasource;
  ProfileRepositoryImpl({required this.remoteDatasource});
  @override
  Future<UserDto> getProfile() async {
    final user = await remoteDatasource.getProfile();
    return user;
  }

}