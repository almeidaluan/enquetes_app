import '../../domain/usercases/Authentication.dart';
import '../http/HttpClient.dart';

class RemoteAuthentication{
  late final HttpClient httpClient;
  late final String url;

  RemoteAuthentication({ required this.httpClient, required this.url});

  Future<void> auth(AuthenticationParams params) async{

    await httpClient.request(url: url, body: RemoteAuthenticationParams.fromEntity(params).toJSON());
  }

}

class RemoteAuthenticationParams{
  final String? email;
  final String? password;

  factory RemoteAuthenticationParams.fromEntity(AuthenticationParams params) => RemoteAuthenticationParams(email: params.email, password: params.secret);

  Map toJSON() => {'email': email, 'password': password};

  RemoteAuthenticationParams({required this.email, required this.password});
}