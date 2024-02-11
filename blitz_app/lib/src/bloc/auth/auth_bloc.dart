import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grade_project_1765532/src/core/model/auth_resp.dart';
import 'package:grade_project_1765532/src/core/service/login_services.dart';
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
      (event, emit) async {
        emit(state.copyWith(loading: true));
        User user = User(
          user: state.userName,
          pass: state.pass,
        );
        AuthResp authdata = await LoginServices().userAuthenticate(user);

        emit(state.copyWith(
          success: authdata.statusCode.startsWith('2'),
          failure: !RegExp(r'^2').hasMatch(authdata.statusCode),
        ));
        emit(state.copyWith(loading: false, success: false, failure: false));
      },
    );
  }
}
