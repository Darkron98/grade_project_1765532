part of 'map_bloc.dart';

class MapState extends Equatable {
  const MapState({
    this.lat = 4.2108,
    this.lng = -76.1561,
    this.srcLat = 0,
    this.srcLng = 0,
  });
  final double lat;
  final double lng;
  final double srcLat;
  final double srcLng;

  MapState copyWith({
    double? lat,
    double? lng,
    double? srcLat,
    double? srcLng,
  }) =>
      MapState(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        srcLat: srcLat ?? this.srcLat,
        srcLng: srcLng ?? this.srcLng,
      );

  @override
  List<Object> get props => [
        lat,
        lng,
        srcLat,
        srcLng,
      ];
}
