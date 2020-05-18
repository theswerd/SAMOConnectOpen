import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:v17/constants.dart';

class LoginCredentials {
  String username;
  String password;
  LoginCredentials({
    @required this.username,
    @required this.password,
  });
  static Future<LoginCredentials> fromSecureStorage() async {
    FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final String username =
        await secureStorage.read(key: SecureStorageKeys.illuminateUsername);
    final String password =
        await secureStorage.read(key: SecureStorageKeys.illuminatePassword);
    return LoginCredentials(
      username: username,
      password: password,
    );
  }
}
