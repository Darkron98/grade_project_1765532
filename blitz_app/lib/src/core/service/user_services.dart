import 'package:dio/dio.dart';
import 'package:grade_project_1765532/src/core/model/register_user.dart';

abstract class UserServiceInterface {
  Future<String> userRegister(RegisterInfo userInfo);
}

class UserService extends UserServiceInterface {
  @override
  Future<String> userRegister(RegisterInfo userInfo) async {
    Map<String, dynamic> body = {
      "password": userInfo.password,
      "user_name": userInfo.userName,
      "first_name": userInfo.name.split(' ')[0],
      "last_name": userInfo.lastName,
      "mail": userInfo.email,
      "phone": userInfo.phone,
      "second_name": userInfo.name.split(' ')[1],
    };

    try {
      Response response = await Dio().post(
        'https://blitz-api-dev.fly.dev/api/v1/user/create',
        data: body,
      );

      return response.statusCode.toString();
    } catch (e) {
      return '400';
    }
  }
}
