import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

baseServiceGet(String url, Map<String, dynamic> map, token) async {
  var res = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // body: jsonEncode(map))
  ).timeout(Duration(seconds: 40));
  print("======> ${res}");
  return res;
}

baseServicePost(String url, Map<String, dynamic> map, token) async {
  var res = await http
      .post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(map))
      .timeout(Duration(seconds: 40));
  print("======> ${res}");
  return res;
}

baseServiceDelete(String url, Map<String, dynamic> map, token) async {
  var res = await http
      .delete(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(map))
      .timeout(Duration(seconds: 40));
  print("======> ${res}");
  return res;
}

baseServicePut(String url, Map<String, dynamic> map, token) async {
  var res = await http
      .put(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(map))
      .timeout(Duration(seconds: 40));
  print("======> ${res}");
  return res;
}

void showMessage(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // dismissDirection: DismissDirection.up,
      backgroundColor: Colors.black,
      content: Text(
        message.toString(),
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 2),
      padding: const EdgeInsets.all(15),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
