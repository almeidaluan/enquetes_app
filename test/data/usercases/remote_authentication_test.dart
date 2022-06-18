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
  RemoteAuthentication sut;
  HttpClientSpy httpClientSpy;
  String url;

  setUp((){
    httpClientSpy = HttpClientSpy();
     url = faker.internet.httpUrl();
     sut = RemoteAuthentication( httpClient: httpClientSpy, url: url);
  });

  test('Should call HttpClient with correct URL',() async{

    final accessToken = faker.guid.guid();
    when(httpClientSpy.request(url: anyNamed('url'), body: anyNamed('body')))
        .thenAnswer((_) async =>
    {'accessToken': accessToken,'name': faker.person.name()});

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

   test('Should throw UnexpectedError if HttpCLient returns 500',() async{
     when(httpClientSpy.request(url: anyNamed('url'), body: anyNamed('body'))).thenThrow(HttpError.serverError);

     final params = AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password());
     final future = sut.auth(params);

     expect(future, throwsA(DomainError.unexpected));

   });

   test('Should throw InvalidCredentials if HttpCLient returns 401',() async{
     when(httpClientSpy.request(url: anyNamed('url'), body: anyNamed('body'))).thenThrow(HttpError.unauthorized);

     final params = AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password());
     final future = sut.auth(params);

     expect(future, throwsA(DomainError.invalidCredentials));

   });


   test('Should return an Account if HttpCLient returns 200',() async{
     final accessToken = faker.guid.guid();

     when(httpClientSpy.request(url: anyNamed('url'), body: anyNamed('body')))
         .thenAnswer((_) async =>
     {'accessToken': accessToken,'name': faker.person.name()});

     final params = AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password());
     final account = await sut.auth(params);

     expect(account.accessToken, accessToken);

   });
}