import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

Future<void> main() async {
  var url = 'https://www.smmusd.org/Page/1155';
  var newdata = [];
  var combine = '';
  List<Map> newlist = [];
  var response = await http.get(url, headers: {});
  if (response.statusCode == 200) {
    Document document = parse(response.body);
    var clubdata =
        document.getElementsByClassName('ui-article-description')[0].innerHtml;
    clubdata = clubdata.replaceAll('</p></span></span>', '');
    var list = clubdata.split('<br><br>');
    list.removeAt(0);
    for (var item in list) {
      if (isWeird(item)) {
        continue;
      }
      var mysplititem = item.split('<br>');
      Map clubmap = new Map();
      clubmap['name'] = mysplititem[0];
      clubmap['meetingday'] = mysplititem[1];
      clubmap['advisor'] = mysplititem[2];
      clubmap['mission'] = mysplititem[3];

      print(clubmap);
      print('\n');
    }
  } else {
    print('Response status: ${response.statusCode}');
  }
}

bool isWeird(String data) {
  if (data.startsWith('Wrestling')) {
    return true;
  } else if (data.startsWith('Lacrosse')) {
    return true;
  } else {
    return false;
  }
}
