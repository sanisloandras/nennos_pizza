import 'package:dio/dio.dart';

class DataApi {
  static const String BASE_URL =
      "https://doclerlabs.github.io/mobile-native-challenge/";

  Future<Response> pizzas() => makeCall('${BASE_URL}pizzas.json');

  Future<Response> ingredients() => makeCall('${BASE_URL}ingredients.json');

  Future<Response> drinks() => makeCall('${BASE_URL}drinks.json');

  Future<Response> makeCall(String path) =>
      Dio().get(path, options: Options(responseType: ResponseType.plain));
}
