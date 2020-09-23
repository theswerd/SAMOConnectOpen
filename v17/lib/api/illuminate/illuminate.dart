import 'package:http/http.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;
import 'package:v17/api/illuminate/class.dart';
import 'package:v17/api/illuminate/gradebook.dart';
import 'package:v17/api/illuminate/loginCredentials.dart';

class IlluminateAPI {
  static String baseURL = "https://smmusd.illuminatehc.com";

  String token = "";
  Gradebook gradebook;

  Future<bool> init() async {
    Response response = await get(baseURL + "/login");
    this.token =
        response.headers["set-cookie"].split(',').last.split(';').first ?? "";
    return this.isInitialized;
  }

  Future<bool> get verifyLogin async {
    try {
      Response response = await get(
        baseURL + "/student-path?login=1",
        headers: {
          "cookie": this.token,
        },
      );
      dom.Document doc = parse(response.body);
      return doc.getElementById("logged-out-header") == null;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getGradebook() async {
    try {
      Response response = await get(
        baseURL + "/gradebooks/",
        headers: {
          "cookie": this.token,
        },
      );
      dom.Document doc = parse(response.body);

      List<dom.Element> unformattedGrades = doc.body
          .getElementsByClassName("ibox-content")
          .last
          .children
          .first
          .children
          .first
          .children
          .last
          .children;
      List<Class> formattedGrades = [];
      for (dom.Element grade in unformattedGrades) {
        formattedGrades.add(
          Class.fromHTML(
            grade,
          ),
        );
      }
      this.gradebook = Gradebook(
        classes: formattedGrades,
      );
      return this.gradebook.classes.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<bool> attemptLogin(LoginCredentials credentials) async {
    try {
      Response response = await post(baseURL + "/login_check",
          headers: {"cookie": this.token},
          body: {"_username": credentials.username, "_password": credentials.password});
      this.token =
          response.headers['set-cookie'].split(",").last.split(";").first;

      return this.verifyLogin;
    } catch (e) {
      return false;
    }
  }

  bool get isInitialized => (token ?? "").isNotEmpty;
}
