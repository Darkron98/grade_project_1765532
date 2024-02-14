import 'package:geolocator/geolocator.dart';
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
  var filePermission = await Permission.mediaLibrary.request();
  if (status.isGranted) {
    print('permiso de ubicacion aceptado');
  } else {
    print('permiso de ubicacion denegado');
  }
}

bool validateLogin(String user, String pass) => user.isEmpty || pass.isEmpty;

Map<String, String> header(String token) =>
    {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
