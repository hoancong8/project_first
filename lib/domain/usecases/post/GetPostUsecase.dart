
import 'package:project_first/app/usecase.dart';
import 'package:project_first/data/dto/auth/post_dto.dart';
import 'package:project_first/domain/repositories/post_repository.dart';

class GetPostUsecase extends UseCaseNoParams<List<PostDto>>{
  final PostRepository repository;
  GetPostUsecase(this.repository);
  @override
  Future<List<PostDto>> call() {
    return repository.getPost();
  }
}
