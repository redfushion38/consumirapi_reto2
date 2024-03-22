import 'dart:typed_data';

import 'package:consumirapireto/data/authentication_client.dart';
import 'package:consumirapireto/helpers/http.dart';
import 'package:consumirapireto/helpers/http_response.dart';
import 'package:consumirapireto/models/user.dart';
import 'package:dio/dio.dart';

class AccountAPI {
  final Http _http;
  final AuthenticationClient _authenticationClient;

  AccountAPI(this._http, this._authenticationClient);

  Future<HttpResponse<User>> getUserInfo() async {
    final token = await _authenticationClient.accessToken;
    return _http.request<User>(
      '/api/v1/user-info',
      method: "GET",
      headers: {
        "token": token!,
      },
      parser: (data) {
        return User.fromJson(data);
      },
    );
  }

  Future<HttpResponse<String>> updateAvatar(
      Uint8List bytes, String? filename) async {
    final token = await _authenticationClient.accessToken;
    return _http.request<String>(
      '/api/v1/update-avatar',
      method: "POST",
      headers: {
        "token": token!,
      },
      formData: {
        "attachment": MultipartFile.fromBytes(
          bytes,
          filename: filename,
        ),
      },
    );
  }
}
