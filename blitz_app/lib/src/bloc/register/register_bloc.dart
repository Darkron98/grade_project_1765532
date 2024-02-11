import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grade_project_1765532/src/core/model/register_user.dart';
import 'package:grade_project_1765532/src/core/service/user_services.dart';

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
    on<TypeLastName>(
      (event, emit) => emit(state.copyWith(lastName: event.lasName)),
    );
    on<TypeUserName>(
      (event, emit) => emit(state.copyWith(userName: event.userName)),
    );
    on<ValidateForm>(
      (event, emit) async {
        if (state.email.isNotEmpty &&
            state.lastName.isNotEmpty &&
            state.name.isNotEmpty &&
            state.password.isNotEmpty &&
            state.confirmationPass.isNotEmpty &&
            state.phone.isNotEmpty &&
            state.userName.isNotEmpty) {
          emit(state.copyWith(loading: true));
          RegisterInfo data = RegisterInfo(
              lastName: state.lastName,
              userName: state.userName,
              name: state.name,
              email: state.email,
              phone: state.phone,
              password: state.password);

          var resp = await UserService().userRegister(data);

          emit(state.copyWith(loading: false));
        }
      },
    );
  }
}
