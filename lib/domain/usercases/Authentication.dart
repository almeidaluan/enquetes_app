

import '../entities/account_entity.dart';

abstract class Authentication{

  Future<AccountEntity> auth(AuthenticationParams params);
}


class AuthenticationParams{

  AuthenticationParams({
    required String email,
    required String secret
  });
}