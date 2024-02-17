import 'package:dio/dio.dart';
import 'package:grade_project_1765532/src/core/model/register_user.dart';

import '../logic/constants.dart' as cons;
import '../logic/functions.dart';
import '../logic/shared_preferences.dart';

abstract class UserServiceInterface {
  Future<String> userRegister(RegisterInfo userInfo);
  Future<String> employeeCreate(RegisterEmployee employeeInfo);
}

class UserService extends UserServiceInterface {
  final Preferences prefs = Preferences();
  @override
  Future<String> userRegister(RegisterInfo userInfo) async {
    var name = userInfo.name.split(' ');
    Map<String, dynamic> body = {
      "password": userInfo.password,
      "user_name": userInfo.userName,
      "first_name": name[0],
      "last_name": userInfo.lastName,
      "mail": userInfo.email,
      "phone": userInfo.phone,
      "second_name": name.length > 1 ? name[1] : '',
    };

    try {
      Response response = await Dio().post(
        '${cons.host}/user/create',
        data: body,
      );

      return response.statusCode.toString();
    } catch (e) {
      return '400';
    }
  }

  @override
  Future<String> employeeCreate(RegisterEmployee employeeInfo) async {
    var name = employeeInfo.name.split(' ');
    Map<String, dynamic> body = {
      "password": employeeInfo.password,
      "user_name": employeeInfo.userName,
      "first_name": name[0],
      "second_name": name.length > 1 ? name[1] : '',
      "last_name": employeeInfo.lastName,
      "mail": employeeInfo.email,
      "phone": employeeInfo.phone,
      "id_doc": employeeInfo.dni,
      "salary": employeeInfo.salary,
    };

    try {
      Response response = await Dio().post(
        '${cons.host}/employee/create',
        data: body,
        options: Options(headers: header(prefs.token)),
      );

      return response.statusCode.toString();
    } catch (e) {
      return '400';
    }
  }
}
