import 'dart:convert';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:my_flutter/data/exceptions/api_exception.dart';

class ApiService {

  Dio _dio;

  ApiService(Dio dio) {
    _dio = dio;
  }
  
  Future<Map<String, dynamic>> invokeHttp(dynamic url, RequestType type, {Map<String, String> headers, dynamic body, Encoding encoding}) async {
    Response response;
    try {
      response = await _invoke(url, type, headers: headers, body: body);
    } catch (error) {
      rethrow;
    }
    
    return response.data;
  }
  
  Future<Response> _invoke(dynamic url, RequestType type, {Map<String, String> headers, dynamic body}) async {
    Response response;

    try {
      switch (type) {
        case RequestType.get:
          response = await _dio.get(url, options: Options(
            headers: headers
          ));
          break;
        case RequestType.post:
          response = await _dio.post(
            url, 
            data: body,
            options: Options(
              headers: headers,
            ));
          break;
        case RequestType.put:
          response = await _dio.put(
            url,
            data: body,
            options: Options(
              headers: headers
            ));
          break;
        case RequestType.delete:
          response = await _dio.delete(url, 
            options: Options(
              headers: headers
            ));
          break;
      }

      // check for any errors
      if (response.statusCode != 200) {
        Map<String, dynamic> body = jsonDecode(response.data);
        throw APIException(
            body['message'], response.statusCode, body['statusText']);
      }

      return response;
    } on DioError {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}

// types used by the helper
enum RequestType { get, post, put, delete }
