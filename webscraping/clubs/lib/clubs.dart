import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

Future<void> main() async {
  var url = 'https://www.smmusd.org/Page/1155';
  var newdata = [];
  var combine = '';
  var response = await http.get(url, headers: {});
  if (response.statusCode == 200) {
    Document document = parse(response.body);
    var clubdata =
        document.getElementsByClassName('ui-article-description')[0].innerHtml;
    for (var i = 40; i < clubdata.length; i++) {
      if (clubdata[i] + clubdata[i + 1] + clubdata[i + 2] + clubdata[i + 3] ==
          '<br>') {
        if (clubdata[i] +
                clubdata[i + 1] +
                clubdata[i + 2] +
                clubdata[i + 3] +
                clubdata[i + 5] ==
            '<br><') {
          i += 9;
        } else {
          for (var j = i - 1; clubdata[j] != '>'; j--) {
            combine += clubdata[j];
          }
          newdata.add(combine.split('').reversed.join(''));
        }
      }
      print(newdata);
    }
  } else {
    print('Response status: ${response.statusCode}');
  }
}
