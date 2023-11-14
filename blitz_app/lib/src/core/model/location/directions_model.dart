import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  final LatLngBounds? bounds;
  final List<PointLatLng>? polylinePoints;
  final String? totalDistance;
  final String? totalDuration;

  const Directions({
    this.bounds,
    this.polylinePoints,
    this.totalDistance,
    this.totalDuration,
  });

  Directions copyWith({
    LatLngBounds? bounds,
    List<PointLatLng>? polylinePoints,
    String? totalDistance,
    String? totalDuration,
  }) =>
      Directions(
        bounds: bounds ?? this.bounds,
        polylinePoints: polylinePoints ?? this.polylinePoints,
        totalDistance: totalDistance ?? this.totalDistance,
        totalDuration: totalDuration ?? this.totalDuration,
      );
}
