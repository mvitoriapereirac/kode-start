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
    try {
      final response = await _dio.get(path);
      return response;
    } on DioException catch (e) {
      // Handle Dio errors (e.g., network issues, server errors)
      throw Exception('Failed to load data: ${e.message}');
    }
  }

  Future<Response> postRequest(String path, dynamic data) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to post data: ${e.message}');
    }
  }

  Future<Response> deleteRequest(String path, dynamic data) async {
    try {
      final response = await _dio.delete(path, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to delete data: ${e.message}');
    }
  }

  Future<Response> putRequest(String path, dynamic data) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to put data: ${e.message}');
    }
  }
}