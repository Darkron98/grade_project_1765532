import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/model/location/directions_model.dart';
import '../../core/service/location_services.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState()) {
    on<SetSrcLocation>(
      (event, emit) => emit(state.copyWith(
        srcLat: event.srcLat,
        srcLng: event.srcLng,
      )),
    );
  }
}
