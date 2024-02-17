import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:grade_project_1765532/src/core/logic/constants.dart' as cons;
import 'package:grade_project_1765532/src/core/logic/functions.dart';
import 'package:grade_project_1765532/src/core/logic/shared_preferences.dart';
import 'package:grade_project_1765532/src/core/model/menu.dart';

abstract class MenuServiceInterface {
  Future<String> createDish(MenuReq req);
  Future<List<Category>> getMenuCategories();
  Future<String> uploadImg(String path);
  Future<List<MenuResp>> getMenuDishes();
  Future<String> updateDish(DishUpdate req);
  Future<String> deleteDish(String id);
}

class MenuService extends MenuServiceInterface {
  final Preferences prefs = Preferences();
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<String> createDish(MenuReq req) async {
    Map<String, dynamic> body = {
      "category_id": req.categoryId,
      "description": req.description,
      "dish_name": req.dishName,
      "label_img": req.labelImg,
      "price": req.price,
    };

    try {
      Response response = await Dio().post(
        '${cons.host}/menu/create',
        data: body,
        options: Options(headers: header(prefs.token)),
      );

      return response.statusCode.toString();
    } catch (e) {
      return '400';
    }
  }

  @override
  Future<List<Category>> getMenuCategories() async {
    try {
      Response response = await Dio().get(
        '${cons.host}/category',
        options: Options(headers: header(prefs.token)),
      );

      List resp = response.data['data'];

      List<Category> data = resp
          .map((e) => Category(
                categoryId: e['category_id'],
                categoryName: e['category_name'],
              ))
          .toList();
      return data;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<String> uploadImg(String path) async {
    try {
      final File file = File(path);

      final String fileName = file.path.split('/').last;

      Reference ref =
          storage.ref().child('images').child('menu').child(fileName);

      final UploadTask task = ref.putFile(file);

      final TaskSnapshot snapShot = await task.whenComplete(() => true);

      final String url = await snapShot.ref.getDownloadURL();

      return url;
    } catch (e) {
      return '';
    }
  }

  @override
  Future<List<MenuResp>> getMenuDishes() async {
    try {
      Response response = await Dio().get(
        '${cons.host}/menu',
        options: Options(headers: header(prefs.token)),
      );

      List data = response.data['data'];

      List<MenuResp> resp = data
          .map(
            (e) => MenuResp(
              dishId: e['dish_id'],
              dishName: e['dish_name'],
              categoryId: e['category_id'],
              price: e['price'],
              description: e['description'],
              labelImg: e['label_img'],
            ),
          )
          .toList();
      return resp;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<String> updateDish(DishUpdate req) async {
    Map<String, dynamic> body = {
      if (req.categoryId != null) ...{
        "category_id": req.categoryId,
      },
      if (req.description != null) ...{
        "description": req.description,
      },
      if (req.dishName != null) ...{
        "dish_name": req.dishName,
      },
      if (req.labelImage != null) ...{
        "label_img": req.labelImage,
      },
      if (req.price != null) ...{
        "price": req.price,
      },
    };

    try {
      Response response = await Dio().put(
        '${cons.host}/menu/update=${req.dishId}',
        data: body,
        options: Options(headers: header(prefs.token)),
      );

      return response.statusCode.toString();
    } catch (e) {
      return '400';
    }
  }

  @override
  Future<String> deleteDish(String id) async {
    try {
      Response response = await Dio().delete(
        '${cons.host}/menu/delete=$id',
        options: Options(headers: header(prefs.token)),
      );

      return response.statusCode.toString();
    } catch (e) {
      return '400';
    }
  }
}
