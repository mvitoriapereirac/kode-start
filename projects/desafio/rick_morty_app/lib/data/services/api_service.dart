import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  final String baseUrl = 'https://https://rickandmortyapi.com/api/';
  ApiService._internal() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  Future<Response> getRequest(String path) async {
    return await _dio.get(path);
  }

  Future<Response> postRequest(String path, dynamic data) async {
    return await _dio.post(path, data: data); 
  }

  Future<Response> deleteRequest(String path, dynamic data) async {
    return await _dio.delete(path, data: data);
  }

  Future<Response> putRequest(String path, dynamic data) async {
    return await _dio.put(path, data: data);
  }
}