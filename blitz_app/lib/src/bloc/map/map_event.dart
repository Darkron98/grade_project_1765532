part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class SetSrcLocation extends MapEvent {
  const SetSrcLocation(
    this.srcLat,
    this.srcLng,
  );
  final double srcLat;
  final double srcLng;

  @override
  List<Object> get props => [
        srcLat,
        srcLng,
      ];
}

class SetLocation extends MapEvent {
  const SetLocation(
    this.lat,
    this.lng,
  );
  final double lat;
  final double lng;

  @override
  List<Object> get props => [
        lat,
        lng,
      ];
}
