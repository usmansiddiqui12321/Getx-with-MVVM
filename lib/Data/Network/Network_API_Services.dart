// ignore: file_names
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:getxwithmvvm/Data/AppExceptions.dart';
import 'package:getxwithmvvm/Data/Network/Base_API_Services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      // Internet Connection Problem
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    } on ServerException {
      throw ServerException();
    }
    return responseJson;
  }

  @override
  Future<dynamic> postApi(dynamic data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data //agr kisi or FORM mn h

              // jsonEncode(data) // agr RAW Form mn h

              )
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      // Internet Connection Problem
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    } on ServerException {
      throw ServerException();
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        dynamic responseJson = jsonDecode(response.body);

        // throw InvalidUrlException('');
        return responseJson;

      default:
        throw FetchDataException(
            'Error Occured while Communicating with server ${response.statusCode}');
    }
  }
}
