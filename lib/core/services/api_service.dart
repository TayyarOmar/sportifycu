import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // Import kIsWeb

class ApiService {
  // Private constructor
  ApiService._privateConstructor() {
    // Determine base URL based on platform
    const String baseUrl =
        kIsWeb ? 'http://localhost:8000' : 'http://10.0.2.2:8000';

    // Initialize Dio with options
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        // connectTimeout: const Duration(seconds: 5),
        // receiveTimeout: const Duration(seconds: 3),
      ),
    );
    // Example: Add interceptors if needed (e.g., for logging, auth)
    // _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  // Static instance
  static final ApiService _instance = ApiService._privateConstructor();

  // Static getter for the instance
  static ApiService get instance => _instance;

  // Dio client
  late Dio _dio;

  // Getter for the Dio client
  Dio get client => _dio;
}
