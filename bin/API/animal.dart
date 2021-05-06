import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:convert' as convert;

Random _random;

class CatApi {
  static Future<String> sendPic() async {
    Uri url;
    String outputMode;

    _random = Random();
    outputMode = ['cat', 'cat/gif'][_random.nextInt(2)];

    return 'https://cataas.com/$outputMode';
  }
}

class DogApi {
  static Future<String> sendPic() async {
    Uri url;
    String result;

    url = Uri.parse('https://dog.ceo/api/breeds/image/random');

    var response = await http.get(url);

    if (response.body.isNotEmpty) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      result = jsonResponse['message'];
    }

    return result;
  }
}
