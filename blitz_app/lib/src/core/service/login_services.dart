import 'package:dio/dio.dart';

import '../model/auth_resp.dart';
import '../model/auth_user.dart';

abstract class LoginServicesInterface {
  Future<AuthResp> userAuthenticate(User user);
}

class LoginServices extends LoginServicesInterface {
  @override
  Future<AuthResp> userAuthenticate(User user) async {
    Map<String, dynamic> body = {
      "user_name": user.user,
      "password": user.pass,
    };

    try {
      Response response = await Dio().post(
        'https://blitz-api-dev.fly.dev/api/v1/auth',
        data: body,
      );

      var respData = response.data;

      AuthResp data = AuthResp(
        user: respData["user"]["user_name"],
        rol: respData["user"]["rol"],
        token: respData["token"],
        statusCode: response.statusCode.toString(),
      );

      return data;
    } catch (e) {
      return const AuthResp(
        user: 'error',
        rol: 0,
        token: 'error',
        statusCode: '400',
      );
    }
  }
}
