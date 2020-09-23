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

  static FlutterSecureStorage secureStorage = FlutterSecureStorage();

  static Future<void> clearCredentials() async {
    await secureStorage.delete(key: SecureStorageKeys.illuminateUsername);
    await secureStorage.delete(key: SecureStorageKeys.illuminatePassword);
    return;
  }

  Future<void> saveCredentials() async {
    await secureStorage.write(
      key: SecureStorageKeys.illuminateUsername,
      value: this.username,
    );
    await secureStorage.write(
      key: SecureStorageKeys.illuminatePassword,
      value: this.password,
    );
    return;
  }

  static Future<LoginCredentials> fromSecureStorage() async {
    final String username =
        await secureStorage.read(key: SecureStorageKeys.illuminateUsername);
    final String password =
        await secureStorage.read(key: SecureStorageKeys.illuminatePassword);
    return LoginCredentials(
      username: username,
      password: password,
    );
  }

  Future<bool> get hasAutoLoginCredentials async {
    LoginCredentials credentials = await fromSecureStorage();
    return ((credentials.username ?? "").isNotEmpty &&
        (credentials.password ?? "").isNotEmpty);
  }
}
