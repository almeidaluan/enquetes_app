class AccountEntity{

  final String accessToken;

  AccountEntity(this.accessToken);

  factory AccountEntity.fromJSON(Map json) =>
      AccountEntity(json['accessToken']);

  AccountEntity toEntity() => AccountEntity(accessToken);


}