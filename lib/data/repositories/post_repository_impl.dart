import 'package:project_first/data/datasource/remote/abstract/post_remote_datasource.dart';
import 'package:project_first/data/datasource/remote/abstract/profile_remote_datasource.dart';
import 'package:project_first/data/dto/auth/post_dto.dart';
import 'package:project_first/data/dto/auth/user_dto.dart';
import 'package:project_first/domain/repositories/post_repository.dart';
import 'package:project_first/domain/repositories/profile_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDatasource;
  PostRepositoryImpl({required this.remoteDatasource});
  @override
  Future<List<PostDto>> getPost() async {
    final posts = await remoteDatasource.getPost();
    return posts;
  }
}
