import 'package:dio/dio.dart';
import 'package:dio/io.dart';

final class RestClient extends DioForNative {
  RestClient()
      : super(
          BaseOptions(
            baseUrl: 'http://172.21.0.241:8080',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 60),
          ),
        ) {
    interceptors.addAll(
      [
        LogInterceptor(
          request: true,
          responseBody: true,
        ),
      ],
    );
  }

  RestClient get auth {
    options.extra['DIO_AUTH_KEY'] = true; // Defina como true ou um valor apropriado
    return this;
  }

  RestClient get unAuth {
    options.extra['DIO_AUTH_KEY'] = false; // Certifique-se de que isso seja apropriado
    return this;
  }
}
