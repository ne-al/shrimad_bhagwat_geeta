import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static Future<List<dynamic>> getAllChapters() async {
    var response = await http.Client()
        .get(Uri.parse('https://bhagavadgitaapi.in/chapters/'));

    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> getChapter(int chpNo) async {
    var response = await http.Client()
        .get(Uri.parse('https://bhagavadgitaapi.in/chapter/$chpNo'));

    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> getSlok(int chpNo, int slokNo) async {
    var response = await http.Client()
        .get(Uri.parse('https://bhagavadgitaapi.in/slok/$chpNo/$slokNo'));

    return json.decode(response.body);
  }
}
