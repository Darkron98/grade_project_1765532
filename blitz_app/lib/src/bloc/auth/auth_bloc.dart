import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../core/model/auth_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<TypeUser>(
      (event, emit) => emit(
        state.copyWith(userName: event.user),
      ),
    );
    on<TypePass>(
      (event, emit) => emit(
        state.copyWith(pass: event.pass),
      ),
    );

    on<Submitted>(
      (event, emit) {},
    );
  }
}
