import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio dio;
  static int() {
    dio = Dio(
      BaseOptions(
          baseUrl: "https://api.themoviedb.org/3/",
          receiveDataWhenStatusError: true,
          responseType: ResponseType.json,
          headers: {
            'language': 'en-US',
          }),
    );
  }

  static Future<Response> getMovies(
      {@required String method,  Map<String, dynamic> query}) async {
    return await dio.get(method, queryParameters: query);
  }
}
