import 'dart:cli';

import 'webhook.dart';
import 'dart:convert';
import 'dart:io';

List urlParser(String url) {
  List urlComponents;
  String id;
  String token;

  urlComponents = url.split('/');
  id = urlComponents[5];
  token = urlComponents[6];

  return [id, token];
}

void storeWebhook() {
  String webhookUrl;
  File jsonFile;
  List rawList;
  String id;
  String token;

  print('Enter the webhook url');
  webhookUrl = stdin.readLineSync();

  rawList = urlParser(webhookUrl);
  id = rawList[0];
  token = rawList[1];

  jsonFile = File('info.json');
  Map data = jsonDecode(jsonFile.readAsStringSync());
  Map dataChannels = data['webhooks'];

  for (var obj in dataChannels.keys) {
    if (obj == id) {
      print('Webhook ID already exists!');
      return;
    }
  }

  data['webhooks'][id] = token;
  jsonFile.writeAsStringSync(json.encode(data));
}

void prepareSendWebhook() {
  File jsonFile;
  int choice;
  int webhookId;
  String webhookToken;
  String animal;

  jsonFile = File('info.json');
  Map data = jsonDecode(jsonFile.readAsStringSync());
  Map dataChannels = data['webhooks'];

  print("List of webhook ID's: ");
  for (var obj in dataChannels.keys) {
    print(obj);
  }

  print('\nEnter your choice: ');
  choice = int.parse(stdin.readLineSync());

  webhookId = choice;
  webhookToken = dataChannels[choice.toString()];

  while (true) {
    print('Enter type of animal: ');
    animal = stdin.readLineSync();

    switch (animal) {
      case 'cat':
        {
          waitFor(Webhook.createWebhook(webhookId, webhookToken, animal));
          break;
        }
      default:
        {
          print('Enter dog or cat!');
          break;
        }
    }
  }
}

void main() {
  int choice;

  mainLoop:
  while (true) {
    print(
        '\nEnter your choice:\n1) Store webhook\n2) Choose and send a webhook');
    choice = int.parse(stdin.readLineSync());

    switch (choice) {
      case 1:
        {
          storeWebhook();
          break;
        }
      case 2:
        {
          prepareSendWebhook();
          break;
        }
      case 3:
        {
          break mainLoop;
        }
      default:
        {
          print('\nEnter a valid value!');
          break;
        }
    }
  }
}
