import 'package:http/http.dart';

class IlluminateAPI {
  final String baseURL = "https://smmusd.illuminatehc.com";

  String token = "";

  Future<bool> init() async {
    Response response = await get(baseURL + "/login");
    this.token =
        response.headers["set-cookie"].split(',').last.split(';').first ?? "";
    return this.isInitialized;
  }

  bool get isInitialized => (token ?? "").isNotEmpty;
}
