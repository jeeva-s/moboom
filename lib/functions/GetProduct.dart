import 'package:dio/dio.dart';

class GetProduct {
  final dio = Dio();

  Future<Response> getProduct({required String url}) async {
    Response response;
    response = await dio.get(url);
    return response;
  }
}
