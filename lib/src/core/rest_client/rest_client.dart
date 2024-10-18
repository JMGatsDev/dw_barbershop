import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dw_barbershop/src/core/rest_client/intercepter/auth_interceptor.dart';

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
        AuthInterceptor(),
      ],
    );
  }

  RestClient get auth {
    options.extra['DIO_AUTH_KEY'] =
        true; // Defina como true ou um valor apropriado
    return this;
  }

  RestClient get unAuth {
    options.extra['DIO_AUTH_KEY'] =
        false; // Certifique-se de que isso seja apropriado
    return this;
  }
}
