import 'package:http/http.dart' as http;
import 'dart:convert';
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
          content = CatApi.sendCatPic();
          break;
        }
    }

    uri = Uri.parse('$baseUrl/webhooks/$webhookId/$webhookToken');

    var response = await http.post(uri, body: {'content': content});
    print(response.statusCode);
    print(response.body);
  }
}
