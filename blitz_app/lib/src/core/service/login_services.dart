import 'package:dio/dio.dart';

import '../logic/shared_preferences.dart';
import '../model/auth_resp.dart';
import '../model/auth_user.dart';
import '../logic/constants.dart' as cons;

abstract class LoginServicesInterface {
  Future<AuthResp> userAuthenticate(User user);
}

class LoginServices extends LoginServicesInterface {
  final Preferences prefs = Preferences();

  @override
  Future<AuthResp> userAuthenticate(User user) async {
    Map<String, dynamic> body = {
      "user_name": user.user,
      "password": user.pass,
    };

    try {
      Response response = await Dio().post(
        '${cons.host}/auth',
        data: body,
      );

      var respData = response.data;

      AuthResp data = AuthResp(
        user: respData["user"]["user_name"],
        rol: respData["user"]["rol"],
        token: respData["token"],
        statusCode: response.statusCode.toString(),
      );

      prefs.token = data.token;
      prefs.user = data.user;
      prefs.rol = data.rol;

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
