import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grade_project_1765532/src/core/model/register_user.dart';
import 'package:grade_project_1765532/src/view/shared/register/register.dart';

import '../../core/service/user_services.dart';

part 'reg_employee_event.dart';
part 'reg_employee_state.dart';

class RegEmployeeBloc extends Bloc<RegEmployeeEvent, RegEmployeeState> {
  RegEmployeeBloc() : super(const RegEmployeeState()) {
    on<TypeEmployeeName>((event, emit) {
      emit(state.copyWith(name: event.name));
    });
    on<TypeEmployeeLatName>((event, emit) {
      emit(state.copyWith(lastNames: event.lastName));
    });
    on<TypeDNI>((event, emit) {
      emit(state.copyWith(dni: event.dni));
    });
    on<TypeEmployeePhone>((event, emit) {
      emit(state.copyWith(phone: event.phone));
    });
    on<TypeSalary>((event, emit) {
      emit(state.copyWith(salary: event.salary));
    });
    on<TypeEmployeeMail>((event, emit) {
      emit(state.copyWith(eMail: event.mail));
    });
    on<TypeEmployeeUser>((event, emit) {
      emit(state.copyWith(user: event.user));
    });
    on<TypeEmployeePass>((event, emit) {
      emit(state.copyWith(pass: event.pass));
    });
    on<TypeEmployeeConfirm>((event, emit) {
      emit(state.copyWith(confirmPass: event.conf));
    });
    on<InfoSubmmitt>((event, emit) async {
      emit(state.copyWith(loadingCreate: true));

      if (state.name.isNotEmpty &&
          state.lastNames.isNotEmpty &&
          state.dni.isNotEmpty &&
          state.phone.isNotEmpty &&
          state.salary > 0 &&
          state.eMail.isNotEmpty &&
          state.user.isNotEmpty &&
          state.pass.isNotEmpty &&
          (state.pass == state.confirmPass)) {
        RegisterEmployee req = RegisterEmployee(
          name: state.name,
          lastName: state.lastNames,
          dni: state.dni,
          phone: state.phone,
          salary: state.salary,
          email: state.eMail,
          userName: state.user,
          password: state.pass,
        );
        var resp = await UserService().employeeCreate(req);

        emit(state.copyWith(
          success: resp.startsWith('2'),
          failure: !RegExp(r'^2').hasMatch(resp),
        ));
      }
      emit(const RegEmployeeState());
    });
    on<GetEmployee>((event, emit) async {
      if (state.dni.isNotEmpty) {
        emit(state.copyWith(loadingCreate: true));
        emit(state.copyWith(
            employee: await UserService().getEmployee(state.dni)));
      }
      emit(state.copyWith(loadingCreate: false));
    });
    on<SetNewState>((event, emit) => emit(const RegEmployeeState()));
  }
}
