import '../../domain/usercases/Authentication.dart';
import '../http/HttpClient.dart';

class RemoteAuthentication{
  late final HttpClient httpClient;
  late final String url;

  RemoteAuthentication({ required this.httpClient, required this.url});

  Future<void> auth(AuthenticationParams params) async{
    await httpClient.request(url: url, body: params.toJSON());
  }

}