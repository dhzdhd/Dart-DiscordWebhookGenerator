import 'package:http/http.dart' as http;
import 'dart:math';

Random _random;

class CatApi {
  static Future<String> sendCatPic() async {
    Uri url;
    String outputMode;

    _random = Random();
    outputMode = ['cat', 'cat/gif'][_random.nextInt(2)];

    url = Uri.parse('https://cataas.com/$outputMode');

    var response = await http.get(url);
    print(response.body);

    return 'e';
  }
}

// class DogApi {
//   Future<String> sendDogPic(request) async {
//     Uri url;
//     String outputMode;

//     _random = Random();
//     outputMode = ['cat', 'cat/gif'][_random.nextInt(2)];

//     url = Uri.parse('https://cataas.com/$outputMode');

//     var response = await http.get(url);
//     print(response.body);

//     return 'e';
//   }
// }
