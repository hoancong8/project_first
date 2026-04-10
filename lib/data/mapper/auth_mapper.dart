import '../../app/mapper.dart';
import '../../domain/entities/auth_token.dart';
import '../dto/auth/auth_dto.dart';

class AuthMapper extends Mapper<AuthDto, AuthToken> {
  @override
  AuthToken map(AuthDto input) {
    return AuthToken(
      accessToken: input.token,
    );
  }
}
