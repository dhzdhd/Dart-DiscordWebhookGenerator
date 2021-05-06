import 'package:http/http.dart' as http;
import 'API/animal.dart';

String baseUrl = 'https://discord.com/api';

class Webhook {
  static Future<void> createWebhook(
      int webhookId, String webhookToken, String choice) async {
    Uri uri;
    var content;

    switch (choice) {
      case 'cat':
        {
          content = await CatApi.sendPic();
          break;
        }
      case 'dog':
        {
          content = await DogApi.sendPic();
          break;
        }
      default:
        {
          return;
        }
    }

    uri = Uri.parse('$baseUrl/webhooks/$webhookId/$webhookToken');
    await http.post(uri, body: {'content': content});

    print('\nSuccess!\n');
  }
}
