import 'package:gitty/feature/auth/data/models/user_model.dart';
import 'package:gitty/feature/auth/domain/entities/user_entity.dart';

class UserMapper {
  static UserMapper instance = UserMapper();

  UserEntity mapModelToEntity({required UserModel userModel}) {
    return UserEntity(
      statusCode: userModel.statusCode,
      data: DataEntity(
        token: userModel.data.token,
        userRecord: UserRecordEntity(
          uid: userModel.data.userRecord.uid,
          tokensValidAfterTime: userModel.data.userRecord.tokensValidAfterTime,
          disabled: userModel.data.userRecord.disabled,
          email: userModel.data.userRecord.email,
          emailVerified: userModel.data.userRecord.emailVerified,
          metadata: MetadataEntity(
            creationTime: userModel.data.userRecord.metadata.creationTime,
            lastRefreshTime: userModel.data.userRecord.metadata.lastRefreshTime,
            lastSignInTime: userModel.data.userRecord.metadata.lastSignInTime,
          ),
          providerData: userModel.data.userRecord.providerData
              .map(
                (e) => ProviderDatumEntity(
                  uid: e.uid,
                  email: e.email,
                  providerId: e.providerId,
                ),
              )
              .toList(),
        ),
      ),
      message: userModel.message,
      success: userModel.success,
    );
  }

  UserModel mapEntityToModel({required UserEntity userEntity}) {
    return UserModel(
      statusCode: userEntity.statusCode,
      data: Data(
        token: userEntity.data.token,
        userRecord: UserRecord(
          disabled: userEntity.data.userRecord.disabled,
          email: userEntity.data.userRecord.email,
          emailVerified: userEntity.data.userRecord.emailVerified,
          tokensValidAfterTime: userEntity.data.userRecord.tokensValidAfterTime,
          uid: userEntity.data.userRecord.uid,
          metadata: Metadata(
            creationTime: userEntity.data.userRecord.metadata.creationTime,
            lastRefreshTime:
                userEntity.data.userRecord.metadata.lastRefreshTime,
            lastSignInTime: userEntity.data.userRecord.metadata.lastSignInTime,
          ),
          providerData: userEntity.data.userRecord.providerData
              .map(
                (e) => ProviderDatum(
                  uid: e.uid,
                  email: e.email,
                  providerId: e.providerId,
                ),
              )
              .toList(),
        ),
      ),
      message: userEntity.message,
      success: userEntity.success,
    );
  }
}
