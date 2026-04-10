

import 'package:project_first/app/usecase.dart';
import 'package:project_first/data/dto/auth/user_dto.dart';
import 'package:project_first/domain/repositories/profile_repository.dart';

class GetProfileUsecase extends UseCaseNoParams<UserDto>{
  final ProfileRepository repository;
  GetProfileUsecase(this.repository);

  @override
  Future<UserDto> call() {
    return repository.getProfile();
  }

}
