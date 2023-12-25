import 'dart:convert';

import 'package:gitty/core/common/constants.dart';
import 'package:gitty/core/common/services.dart';
import 'package:gitty/core/local_storage/keys.dart';
import 'package:gitty/core/local_storage/storage.dart';
import 'package:gitty/feature/auth/data/models/user_model.dart';
import 'package:gitty/feature/auth/domain/entities/user_entity.dart';
import 'package:gitty/feature/auth/utils/user_mapper.dart';

class AuthService {
  final client = HttpService.instance.httpClient;

  Future<UserEntity?> registerUser({
    required String email,
    required String password,
  }) async {
    UserEntity? user;
    bool isEmailSet = false;
    bool isTokenSet = false;
    bool isLoggedInSet = false;
    try {
      final url = '${AppConstants.instance.baseUrl}register';

      final data = {
        "email": email,
        "password": password,
      };

      final headers = {
        "Content-Type": 'application/json',
      };

      final uri = Uri.parse(url);

      final response = await client.post(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        UserModel userModel = userModelFromJson(response.body);
        user = UserMapper.instance.mapModelToEntity(userModel: userModel);
        isTokenSet = await LocalStorage.instance.writeStringToLocalDb(
          key: AppLocalStorageKeys.instance.userToken,
          value: user.data.token,
        );
        isEmailSet = await LocalStorage.instance.writeStringToLocalDb(
          key: AppLocalStorageKeys.instance.userEmail,
          value: user.data.userRecord.email,
        );
        isLoggedInSet = await LocalStorage.instance.writeBoolToLocalDb(
          key: AppLocalStorageKeys.instance.isLoggedIn,
          value: true,
        );
      }
    } catch (error) {
      print("Error while registering user -- API: $error");
    }

    if (isLoggedInSet && isEmailSet && isTokenSet) {
      return user;
    }

    return null;
  }

  Future<UserEntity?> loginUser({
    required String email,
  }) async {
    UserEntity? user;
    bool isEmailSet = false;
    bool isTokenSet = false;
    bool isLoggedInSet = false;
    try {
      final url = '${AppConstants.instance.baseUrl}login';

      final data = {
        "email": email,
      };

      final headers = {
        "Content-Type": 'application/json',
      };

      final uri = Uri.parse(url);

      final response = await client.post(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        UserModel userModel = userModelFromJson(response.body);
        user = UserMapper.instance.mapModelToEntity(userModel: userModel);
        isTokenSet = await LocalStorage.instance.writeStringToLocalDb(
          key: AppLocalStorageKeys.instance.userToken,
          value: user.data.token,
        );
        isEmailSet = await LocalStorage.instance.writeStringToLocalDb(
          key: AppLocalStorageKeys.instance.userEmail,
          value: user.data.userRecord.email,
        );
        isLoggedInSet = await LocalStorage.instance.writeBoolToLocalDb(
          key: AppLocalStorageKeys.instance.isLoggedIn,
          value: true,
        );
      }
    } catch (error) {
      print("Error while registering user -- API: $error");
    }
    if (isLoggedInSet && isEmailSet && isTokenSet) {
      return user;
    }

    return null;
  }
}
