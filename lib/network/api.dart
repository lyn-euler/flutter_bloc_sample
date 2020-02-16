import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class Api {
  static get rap => _api();

  static Dio _rap2api;
  static Dio _api() {

    if (_rap2api != null) return _rap2api;

    final _options = BaseOptions(baseUrl: 'http://rap2api.taobao.org/app/mock/10066/');
    _rap2api = Dio(_options);

    /*设置代理*/
//    (_rap2api.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
//      // config the http client
//      client.findProxy = (uri) {
//        //proxy all request to localhost:8888
//        return "PROXY localhost:8888";
//      };
//    };

    return _rap2api;
  }
}
