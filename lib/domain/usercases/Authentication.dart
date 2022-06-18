

import '../entities/account_entity.dart';

abstract class Authentication{

  Future<AccountEntity> auth(AuthenticationParams params);
}

class AuthenticationParams{
  String email;
  String secret;

  AuthenticationParams({
      String email,
      String secret
  });

}