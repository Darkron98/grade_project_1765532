import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  if (status.isGranted) {
    print('permiso de ubicacion aceptado');
  } else {
    print('permiso de ubicacion denegado');
  }
}
