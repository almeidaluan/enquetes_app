import 'dart:io';

import 'package:enquetes_app/data/http/HttpClient.dart';
import 'package:enquetes_app/data/http/HttpError.dart';
import 'package:enquetes_app/data/usercases/RemoteAuthentication.dart';
import 'package:enquetes_app/domain/helpers/DomainError.dart';
import 'package:enquetes_app/domain/usercases/Authentication.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

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

  test('Should throw UnexpectedError if HttpCLient returns 400',() async{
    when(httpClientSpy.request(url: anyNamed('url'), body: anyNamed('body'))).thenThrow(HttpError.badRequest);
    
    final params = AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password());
    final future = sut.auth(params);
    
    expect(future, throwsA(DomainError.unexpected));

  });

   test('Should throw NotFound if HttpCLient returns 404',() async{
     when(httpClientSpy.request(url: anyNamed('url'), body: anyNamed('body'))).thenThrow(HttpError.notFound);

     final params = AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password());
     final future = sut.auth(params);

     expect(future, throwsA(DomainError.unexpected));

   });
}