import 'package:enquetes_app/domain/usercases/Authentication.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';


class RemoteAuthentication{
  late final HttpClient httpClient;
  late final String url;

  RemoteAuthentication({ required this.httpClient, required this.url});

  Future<void> auth(AuthenticationParams params) async{

    final body = {'email': params.email, 'password': params.secret};

    await httpClient.request(url: url, body: body);
  }

}

abstract class HttpClient{
  Future<void>? request({required String url, Map body});
}

class HttpClientSpy extends Mock implements HttpClient{

}

void main(){
  late final RemoteAuthentication sut;
  late final HttpClientSpy httpClientSpy;
  late final String url;

  setUp((){
    httpClientSpy = HttpClientSpy();
     url = faker.internet.httpUrl();
     sut = RemoteAuthentication( httpClient: httpClientSpy, url: url);
  });

  test('Should call HttpClient with correct URL',() async{
    final params = AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password());
    await sut.auth(params);
    verify(httpClientSpy.request(url: url, body: {'email':params.email,'password': params.secret}
    ));
  });
}