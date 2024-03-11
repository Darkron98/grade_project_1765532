import 'package:dio/dio.dart';
import 'package:grade_project_1765532/src/core/model/register_user.dart';

import '../logic/constants.dart' as cons;
import '../logic/functions.dart';
import '../logic/shared_preferences.dart';

abstract class UserServiceInterface {
  Future<String> userRegister(RegisterInfo userInfo);
  Future<String> employeeCreate(RegisterEmployee employeeInfo);
  Future<List<RegisterEmployee>> getEmployee(String dni);
  Future<String> updateEmployee(EmployeeUpdate employeeInfo, String id);
  Future<String> fireEmployee(String id);
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

  @override
  Future<List<RegisterEmployee>> getEmployee(String dni) async {
    try {
      Response response = await Dio().get(
        '${cons.host}/employee/$dni',
        options: Options(headers: header(prefs.token)),
      );

      var data = response.data;

      List<RegisterEmployee> resp = [];

      resp.add(
        RegisterEmployee(
          lastName: data['data']['user_data']['last_name'],
          userName: data['data']['user_name'],
          name:
              '${data['data']['user_data']['first_name']} ${data['data']['user_data']['second_name']}',
          email: data['data']['user_data']['mail'],
          phone: data['data']['user_data']['phone'],
          password: '',
          dni: dni,
          salary:
              double.parse(data['data']['employee_data']['salary'].toString()),
        ),
      );

      return resp;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<String> updateEmployee(EmployeeUpdate employeeInfo, String id) async {
    var name = employeeInfo.name != null ? employeeInfo.name!.split(' ') : null;
    Map<String, dynamic> body = {
      if (name != null) ...{
        "first_name": name[0],
      },
      if (name != null) ...{
        "second_name": name.length > 1 ? name[1] : '',
      },
      if (employeeInfo.lastName != null) ...{
        "last_name": employeeInfo.lastName,
      },
      if (employeeInfo.dni != null) ...{
        "id_doc": employeeInfo.dni,
      },
      if (employeeInfo.phone != null) ...{
        "phone": employeeInfo.phone,
      },
      if (employeeInfo.email != null) ...{
        "mail": employeeInfo.email,
      },
      if (employeeInfo.salary != null) ...{
        "salary": employeeInfo.salary,
      },
    };
    try {
      Response response = await Dio().put(
        '${cons.host}/employee/update=$id',
        data: body,
        options: Options(headers: header(prefs.token)),
      );

      return response.statusCode.toString();
    } catch (e) {
      return '400';
    }
  }

  @override
  Future<String> fireEmployee(String id) async {
    try {
      Response response = await Dio().patch(
        '${cons.host}/employee/dismiss=$id',
        options: Options(headers: header(prefs.token)),
      );

      return response.statusCode.toString();
    } catch (e) {
      return '400';
    }
  }
}
