import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:math';
import 'dart:convert' as convert;

void main(List<String> arguments) async {
  var url = Uri.https('stoic-quotes.com', '/api/quote');

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var text = jsonResponse['text'];
    var author = jsonResponse['author'];
    print('Text: $text');
    print('\nAuthor: $author.');
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
}
