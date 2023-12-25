class UserEntity {
  int statusCode;
  DataEntity data;
  String message;
  bool success;

  UserEntity({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });
}

class DataEntity {
  UserRecordEntity userRecord;
  String token;

  DataEntity({
    required this.userRecord,
    required this.token,
  });
}

class UserRecordEntity {
  String uid;
  String email;
  bool emailVerified;
  bool disabled;
  MetadataEntity metadata;
  String tokensValidAfterTime;
  List<ProviderDatumEntity> providerData;

  UserRecordEntity({
    required this.uid,
    required this.email,
    required this.emailVerified,
    required this.disabled,
    required this.metadata,
    required this.tokensValidAfterTime,
    required this.providerData,
  });
}

class MetadataEntity {
  dynamic lastSignInTime;
  String creationTime;
  dynamic lastRefreshTime;

  MetadataEntity({
    required this.creationTime,
    required this.lastRefreshTime,
    required this.lastSignInTime,
  });
}

class ProviderDatumEntity {
  String uid;
  String email;
  String providerId;

  ProviderDatumEntity({
    required this.uid,
    required this.email,
    required this.providerId,
  });
}
