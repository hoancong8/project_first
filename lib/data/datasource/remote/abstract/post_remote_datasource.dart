
import 'package:project_first/data/dto/auth/post_dto.dart';

abstract class PostRemoteDataSource{
  Future<List<PostDto>> getPost();
}