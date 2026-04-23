import 'package:project_first/data/dto/auth/post_dto.dart';
abstract class PostRepository {
  Future<List<PostDto>> getPost();
}
