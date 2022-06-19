import 'package:enquetes_app/data/http/http.dart';
import 'package:enquetes_app/domain/entities/account_entity.dart';

class RemoteAccountModel{

  final String accessToken;

  RemoteAccountModel(this.accessToken);

  factory RemoteAccountModel.fromJSON(Map json) {
    if(!json.containsKey('accessToken')){
      throw HttpError.invalidData;
    }
    return RemoteAccountModel(json['accessToken']);
  }



  AccountEntity toEntity() => AccountEntity(accessToken);


}