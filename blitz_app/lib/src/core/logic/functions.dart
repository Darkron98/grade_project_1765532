import 'package:geolocator/geolocator.dart';
import 'package:grade_project_1765532/src/core/logic/shared_preferences.dart';
import 'package:grade_project_1765532/src/core/model/menu.dart';
import 'package:permission_handler/permission_handler.dart';

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

void getLocationPermission() async {
  var status = await Permission.location.request();
  if (!status.isGranted) {}
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
    '${date.day < 10 ? 0 : ''}${date.day}/${date.month < 10 ? 0 : ''}${date.month}/${date.year}  ${date.hour < 10 ? 0 : ''}${date.hour - (date.hour > 12 ? 12 : 0)}:${date.minute < 10 ? 0 : ''}${date.minute} ${date.hour > 12 && date.minute > 0 ? 'PM' : 'AM'}';
