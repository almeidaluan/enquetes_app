import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';


class RemoteAuthentication{
  late final HttpClient httpClient;
  late final String url;

  RemoteAuthentication({ required this.httpClient, required this.url});

  Future<void> auth() async{
    await httpClient.request(url: url);
  }

}

abstract class HttpClient{
  Future<void>? request({required String url});
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

    await sut.auth();
    verify(httpClientSpy.request(url: url));

  });
}