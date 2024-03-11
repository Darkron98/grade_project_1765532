import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(const MapState()) {
    on<SetSrcLocation>(
      (event, emit) => emit(state.copyWith(
        srcLat: event.srcLat,
        srcLng: event.srcLng,
      )),
    );
    on<SetLocation>(
      (event, emit) => emit(state.copyWith(
        lat: event.lat,
        lng: event.lng,
      )),
    );
  }
}
