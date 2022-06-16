import 'package:enquetes_app/data/http/HttpError.dart';
import 'package:enquetes_app/domain/helpers/DomainError.dart';

import '../../domain/usercases/Authentication.dart';
import '../http/HttpClient.dart';

class RemoteAuthentication{
  late final HttpClient httpClient;
  late final String url;

  RemoteAuthentication({ required this.httpClient, required this.url});

  Future<void> auth(AuthenticationParams params) async{

    try{
        await httpClient.request(url: url, body: RemoteAuthenticationParams.fromEntity(params).toJSON());
    } on HttpError catch(error){
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }

}

class RemoteAuthenticationParams{
  final String? email;
  final String? password;

  factory RemoteAuthenticationParams.fromEntity(AuthenticationParams params) => RemoteAuthenticationParams(email: params.email, password: params.secret);

  Map toJSON() => {'email': email, 'password': password};

  RemoteAuthenticationParams({required this.email, required this.password});
}