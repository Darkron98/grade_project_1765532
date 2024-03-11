import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<ChangePage>((event, emit) => emit(
          state.copyWith(indexPage: event.page),
        ));
    on<NewOrder>(
      (event, emit) => emit(state.copyWith(newOrder: event.newOrder)),
    );
  }
}
