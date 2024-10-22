import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/constants/local_storege_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;
    const authHeaferKey = 'Authorization';
    headers.remove(authHeaferKey);

    if (extra case {'DIO_AUTH_KEY': true}) {
      final token = await SharedPreferences.getInstance();
      headers.addAll(
        {
          authHeaferKey: 'Bearer ${token.getString(
            LocalStoregeKeys.accessToken,
          )} '
        },
      );
    }

    handler.next(options);
  }
}
