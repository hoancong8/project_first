import 'package:project_first/data/datasource/remote/auth_remote_datasource.dart';
import 'package:project_first/data/mapper/auth_mapper.dart';
import 'package:project_first/domain/entities/auth_token.dart';
import 'package:project_first/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource; // Thay vì gọi mock trực tiếp
  final AuthMapper mapper;

  AuthRepositoryImpl({required this.remoteDataSource, required this.mapper});

  @override
  Future<AuthToken> login(String username, String password) async {
    // Gọi API thật thông qua datasource
    final dto = await remoteDataSource.login(username, password);
    // Map dữ liệu từ DTO sang Entity rồi trả về cho Domain
    return mapper.map(dto);
  }
  @override
  Future<String> register(String username, String password,String name) async {
    return await remoteDataSource.register(username,password,name);

  }
}