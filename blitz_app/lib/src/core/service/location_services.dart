import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';

import '../model/location/directions_model.dart';

abstract class LocationServicesInterface {
  Future<Directions> getDirections(LatLng origin, LatLng destination);
}

class LocationServices extends LocationServicesInterface {
  @override
  Future<Directions> getDirections(LatLng origin, LatLng destination) async {
    try {
      final response = await Dio().get(
          'https://maps.googleapis.com/maps/api/directions/json?',
          queryParameters: {
            'origin': '${origin.latitude},${origin.longitude}',
            'destination': '${destination.latitude},${destination.longitude}',
            'key': 'AIzaSyD9KHPOIW5Mka2Kt6eTmZzzW6jj7RgxDZQ',
          });

      final data = Map<String, dynamic>.from(response.data['routes'][0]);

      // Bounds
      final northeast = data['bounds']['northeast'];
      final southwest = data['bounds']['southwest'];
      final bounds = LatLngBounds(
        northeast: LatLng(northeast['lat'], northeast['lng']),
        southwest: LatLng(southwest['lat'], southwest['lng']),
      );

      // Distance & Duration
      String distance = '';
      String duration = '';
      if ((data['legs'] as List).isNotEmpty) {
        final leg = data['legs'][0];
        distance = leg['distance']['text'];
        duration = leg['duration']['text'];
      }

      return Directions(
        bounds: bounds,
        polylinePoints: PolylinePoints()
            .decodePolyline(data['overview_polyline']['points']),
        totalDistance: distance,
        totalDuration: duration,
      );
    } catch (e) {
      return const Directions();
    }
  }
}
