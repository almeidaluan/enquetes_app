import 'package:enquetes_app/data/http/HttpError.dart';
import 'package:enquetes_app/data/models/RemoteAccountModel.dart';
import 'package:enquetes_app/domain/entities/account_entity.dart';
import 'package:enquetes_app/domain/helpers/DomainError.dart';

import '../../domain/usercases/Authentication.dart';
import '../http/HttpClient.dart';

class RemoteAuthentication{
   final HttpClient httpClient;
   final String url;

  RemoteAuthentication({ this.httpClient, this.url});

  Future<AccountEntity> auth(AuthenticationParams params) async{

    try{
         final httpResponse = await httpClient.request(url: url, body: RemoteAuthenticationParams.fromEntity(params).toJSON());
         return RemoteAccountModel.fromJSON(httpResponse).toEntity();
    } on HttpError catch(error){
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams{
  final String email;
  final String password;

  factory RemoteAuthenticationParams.fromEntity(AuthenticationParams params) => RemoteAuthenticationParams(email: params.email, password: params.secret);

  Map toJSON() => {'email': email, 'password': password};

  RemoteAuthenticationParams({ this.email,  this.password});
}