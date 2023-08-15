import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;
  late dynamic decodedData;

  Future<dynamic> getData() async {
    final encoded = Uri.parse(url);
    Map<String, String> header = {
      "X-CoinAPI-Key": "FB8931D1-399A-4824-BCCC-58AAD0E6DF09"
    };

    final response = await http.get(encoded, headers: header);
    debugPrint(response.body.toString());

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      debugPrint(response.statusCode.toString());
      return null;
    }
  }
}
