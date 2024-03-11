import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:grade_project_1765532/src/core/logic/constants.dart' as cons;
import 'package:grade_project_1765532/src/core/logic/functions.dart';
import 'package:grade_project_1765532/src/core/logic/shared_preferences.dart';
import 'package:grade_project_1765532/src/core/model/cart/order.dart';
import 'package:grade_project_1765532/src/core/model/menu.dart';
import 'package:grade_project_1765532/src/core/service/location_services.dart';

import 'notification_service.dart';

abstract class MenuServiceInterface {
  Future<String> createDish(MenuReq req);
  Future<List<Category>> getMenuCategories();
  Future<String> uploadImg(String path);
  Future<List<MenuResp>> getMenuDishes();
  Future<String> updateDish(DishUpdate req);
  Future<String> deleteDish(String id);
  Future<List<CategoryDishes>> getWithCategories();
  Future<String> createOrder(OrderReq req);
  Future<List<OrderResp>> getOrders();
  Future<String> cancelOrder(String id);
  Future<String> takeOrder(String id);
  Future<String> orderShipped(String id);
  Future<List<OrderItem>> getItemsByOrderId(String id);
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
      data.sort((a, b) => a.categoryName.compareTo(b.categoryName));
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
      resp.sort((a, b) {
        return a.dishName.compareTo(b.dishName);
      });
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

  @override
  Future<List<CategoryDishes>> getWithCategories() async {
    try {
      Response response = await Dio().get(
        '${cons.host}/menu/getMenuWithcategory',
        options: Options(headers: header(prefs.token)),
      );

      List data = response.data['data'];

      List<CategoryDishes> resp = data.map((e) {
        List dataDishes = e['dishes'];

        List<MenuResp> dishes = dataDishes
            .map((dish) => MenuResp(
                  dishId: dish['dish_id'],
                  description: dish['description'],
                  dishName: dish['dish_name'],
                  labelImg: dish['label_img'],
                  price: dish['price'],
                ))
            .toList();
        dishes.sort((a, b) => a.dishName.compareTo(b.dishName));
        return CategoryDishes(
          categoryId: e['category_id'],
          categoryName: e['category_name'],
          dishes: dishes,
        );
      }).toList();
      resp.sort((a, b) => a.categoryName.compareTo(b.categoryName));
      return resp;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<String> createOrder(OrderReq req) async {
    List<Map<String, dynamic>> items = req.items
        .map((e) => {
              "item_desc": e.itemDesc,
              "item_id": e.itemId,
              "quantity": e.quantity,
              "unit_price": e.unitPrice
            })
        .toList();
    double totalPrice = 0;
    for (int i = 0; i < items.length; i++) {
      totalPrice = totalPrice + (items[i]["unit_price"] * items[i]["quantity"]);
    }
    String address =
        await LocationServices().getPhysicalDirection(req.lat, req.lng);
    Map<String, dynamic> body = {
      "address_name": address,
      "lat": req.lat,
      "lng": req.lng,
      'date': DateTime.now().toIso8601String(),
      "total_price": totalPrice,
      "observations": req.observations,
      "delivery_id": '',
      "items": items,
    };

    try {
      Response response = await Dio().post(
        '${cons.host}/order/create',
        data: body,
        options: Options(headers: header(prefs.token)),
      );
      if (response.statusCode.toString().startsWith('2')) {
        sendNotificationToTopic('personal');
      }
      return response.statusCode.toString();
    } catch (e) {
      return '400';
    }
  }

  @override
  Future<List<OrderResp>> getOrders() async {
    String method = prefs.rol == 3 ? 'order/getOrdersByUser' : 'order';
    try {
      Response response = await Dio().get(
        '${cons.host}/$method',
        options: Options(headers: header(prefs.token)),
      );

      List data = response.data['orders'];

      List<OrderResp> resp = data
          .map((e) => OrderResp(
              id: e["id"],
              owner: e["owner"],
              ownerId: e["owner_id"],
              state: e["state"],
              date: DateTime.parse(e["date"]),
              taken: e["taken"],
              canceled: e["canceled"],
              addressName: e["address_name"],
              lat: e["lat"],
              lng: e["lng"],
              totalPrice: double.parse(e["total_price"].toString()),
              observations: e["observations"],
              deliveryId: '',
              items: []))
          .toList();
      resp.removeWhere((item) => item.canceled);
      resp.sort((a, b) => a.date.compareTo(b.date));
      return resp;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<String> cancelOrder(String id) async {
    try {
      Response response = await Dio().delete(
        '${cons.host}/order/cancel=$id',
        options: Options(headers: header(prefs.token)),
      );
      if (response.statusCode.toString().startsWith('2')) {
        sendNotificationToTopic('personal');
      }
      return response.statusCode.toString();
    } catch (e) {
      return '400';
    }
  }

  @override
  Future<String> takeOrder(String id) async {
    try {
      Response response = await Dio().patch(
        '${cons.host}/order/take=$id',
        options: Options(headers: header(prefs.token)),
      );
      if (response.statusCode.toString().startsWith('2')) {
        sendNotificationToTopic('personal');
      }
      return response.statusCode.toString();
    } catch (e) {
      return '400';
    }
  }

  @override
  Future<String> orderShipped(String id) async {
    try {
      Response response = await Dio().patch(
        '${cons.host}/order/shipped=$id',
        options: Options(headers: header(prefs.token)),
      );
      if (response.statusCode.toString().startsWith('2')) {
        sendNotificationToTopic('personal');
      }
      return response.statusCode.toString();
    } catch (e) {
      return '400';
    }
  }

  @override
  Future<List<OrderItem>> getItemsByOrderId(String id) async {
    try {
      Response response = await Dio().get(
        '${cons.host}/order/getItems=$id',
        options: Options(headers: header(prefs.token)),
      );

      List data = response.data;

      List<OrderItem> resp = data
          .map((e) => OrderItem(
                itemDesc: e["item_desc"],
                itemId: e["item_id"],
                labelImg: '',
                quantity: e["quantity"],
                unitPrice: double.parse(e["unit_price"].toString()),
              ))
          .toList();
      return resp;
    } catch (e) {
      return [];
    }
  }
}
