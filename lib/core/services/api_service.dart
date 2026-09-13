import 'package:dio/dio.dart';
import '../../config/constants/api_endpoints.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiEndpoints.cloudFunctionsBase,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // TODO: attach firebase auth token
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        // TODO: log errors and retry
        return handler.next(e);
      },
    ));
  }

  Dio get client => _dio;
}
