import '../../../app/usecase.dart';
import '../../entities/auth_token.dart';
import '../../repositories/auth_repository.dart';

class RegisterParams {
  final String email;
  final String password;
  final String name;
  RegisterParams({required this.email, required this.password,required this.name});
}

class RegisterUsecase extends UseCase<String, RegisterParams> {
  final AuthRepository repository;
  RegisterUsecase(this.repository);
  @override
  Future<String> call(RegisterParams params) async {
    return await repository.register(params.email, params.password,params.name);
  }
}
