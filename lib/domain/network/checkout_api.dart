import 'package:dio/dio.dart';

class CheckoutApi {
  Future<Response> checkout(data) {
    return Dio().post('http://httpbin.org/post',
        data: data,
        options: Options(responseType: ResponseType.plain));
  }
}