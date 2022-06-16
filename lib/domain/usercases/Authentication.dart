

import '../entities/account_entity.dart';

abstract class Authentication{

  Future<AccountEntity> auth(AuthenticationParams params);
}


class AuthenticationParams{
  String? email;
  String? secret;

  AuthenticationParams({
    required String email,
    required String secret
  });

  Map toJSON() => {'email': email, 'password': secret};
}