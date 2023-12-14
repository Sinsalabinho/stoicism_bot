import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class StoicQuoteFetcher {
  Future<String?> fetchQuote() async {
    var url = Uri.https('stoic-quotes.com', '/api/quote');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var text = jsonResponse['text'];
      var author = jsonResponse['author'];
      var combinedContent = '$text\n-$author';
      return combinedContent;
    } else {
      print('Request failed with status: ${response.statusCode}');
      return null;
    }
  }
}
