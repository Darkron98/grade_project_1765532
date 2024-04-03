// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grade_project_1765532/src/core/logic/shared_preferences.dart';
import 'package:grade_project_1765532/src/core/model/menu.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:notification_permissions/notification_permissions.dart'
    as notification;
import 'package:permission_handler/permission_handler.dart' as locate;

import '../../view/shared/login/login.dart';
import '../model/cart/order.dart';

Future<double> getLocationLat() async {
  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double latitud = position.latitude;
    return latitud;
  } catch (e) {
    return 0;
  }
}

Future<double> getLocationLong() async {
  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double longitude = position.longitude;
    return longitude;
  } catch (e) {
    return 0;
  }
}

Future<locate.PermissionStatus> getLocationPermission() async {
  var status = await locate.Permission.location.request();
  return status;
}

Future<notification.PermissionStatus> getNotiPermission(
    BuildContext context) async {
  var status = await notification.NotificationPermissions
      .getNotificationPermissionStatus();
  if (status.name != 'granted') {
    notificationAlert(context);
  }

  return status;
}

bool validadeDishcreate(MenuReq dish) =>
    dish.dishName.isEmpty ||
    dish.price == 0 ||
    dish.description.isEmpty ||
    dish.categoryId.isEmpty;

bool validateLogin(String user, String pass) {
  var userpref = Preferences().remainUser;
  return (user.isEmpty || pass.isEmpty) &&
      (Preferences().remainUser.isEmpty || pass.isEmpty);
}

Map<String, String> header(String token) =>
    {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};

String formatDate(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}   ${formatHour(date)}';

String formatHour(DateTime dateTime) {
  String period = dateTime.hour < 12 ? 'AM' : 'PM';
  int hour = dateTime.hour % 12;
  if (hour == 0) {
    hour = 12;
  }
  return '${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} $period';
}

bool validateDishQuantity(String id, List<OrderItem> items) {
  bool val = false;
  for (int i = 0; i < items.length; i++) {
    if (items[i].itemId == id) {
      val = items[i].quantity == 10;
      break;
    }
  }
  return !val;
}

double getOrderTotal(List<OrderItem> items) {
  double total = 0;
  for (int i = 0; i < items.length; i++) {
    total = total + (items[i].unitPrice * items[i].quantity);
  }
  return total;
}

String formatOrderItems(List<OrderItem> items) {
  String formatString = '';
  double totalPrice = 0;
  for (int i = 0; i < items.length; i++) {
    formatString =
        '$formatString * ${items[i].itemDesc} : ${items[i].quantity}\n';
    totalPrice = totalPrice + items[i].unitPrice * items[i].quantity;
  }
  return formatString =
      '${formatString}Total : \$ ${MoneyFormatter(amount: totalPrice).output.withoutFractionDigits}';
}
