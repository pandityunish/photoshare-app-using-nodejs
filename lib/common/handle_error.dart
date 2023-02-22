import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void showsnackbar(BuildContext context, String name) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(name)));
}

Future<http.Response> handleerror(
    {required http.Response res,
    required VoidCallback callback,
    required BuildContext context}) async {
  switch (res.statusCode) {
    case 200:
      callback();
      break;
    case 400:
      showsnackbar(context, jsonDecode(res.body)["mes"]);
      break;
    case 500:
      showsnackbar(context, jsonDecode(res.body)["mes"]);
      break;
    default:
      showsnackbar(context, jsonDecode(res.body)["mes"]);
  }
  return res;
}
