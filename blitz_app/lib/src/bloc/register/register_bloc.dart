import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grade_project_1765532/src/core/model/register_user.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<TypeName>(
      (event, emit) => emit(state.copyWith(name: event.name)),
    );
    on<TypeEmail>(
      (event, emit) => emit(state.copyWith(email: event.email)),
    );
    on<TypePhone>(
      (event, emit) => emit(state.copyWith(phone: event.phone)),
    );
    on<TypePassword>(
      (event, emit) => emit(state.copyWith(password: event.pass)),
    );
    on<ConfirmationPass>(
      (event, emit) => emit(state.copyWith(confirmationPass: event.confPass)),
    );
  }
}
