import 'package:dio/dio.dart';

class AppDefaultHeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    //final locale = await _localizationRepository.loadLocalization();
    //options.headers['Cookie'] = 'lang=$locale';
    super.onRequest(options, handler);
  }
}
