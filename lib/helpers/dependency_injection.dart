import 'package:consumirapireto/Api/account_api.dart';
import 'package:consumirapireto/Api/authentication_api.dart';
import 'package:consumirapireto/data/authentication_client.dart';
import 'package:consumirapireto/helpers/http.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:get_it/get_it.dart';

abstract class DependencyInjection {
  static void initialize() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.1.75:9000',
      ),
    );
    Logger logger = Logger();
    Http http = Http(
      dio: dio,
      logger: logger,
      logsEnabled: true,
    );
    const secureStorage = FlutterSecureStorage();
    final authenticationAPI = AuthenticationAPI(http);
    final authenticationClient = AuthenticationClient(
      secureStorage,
      authenticationAPI,
    );
    final accountAPI = AccountAPI(http, authenticationClient);

    GetIt.instance.registerSingleton<AuthenticationAPI>(authenticationAPI);
    GetIt.instance
        .registerSingleton<AuthenticationClient>(authenticationClient);
    GetIt.instance.registerSingleton<AccountAPI>(accountAPI);
  }
}
