part of 'reg_employee_bloc.dart';

class RegEmployeeState extends Equatable {
  const RegEmployeeState({
    this.name = '',
    this.lastNames = '',
    this.dni = '',
    this.phone = '',
    this.eMail = '',
    this.user = '',
    this.pass = '',
    this.confirmPass = '',
    this.salary = 0,
    this.employee = const [],
    this.loadingCreate = false,
    this.loadingDelete = false,
    this.loadingUpdate = false,
    this.success = false,
    this.failure = false,
    this.delSuccess = false,
    this.delFailure = false,
  });

  final String name;
  final String lastNames;
  final String dni;
  final String phone;
  final String eMail;
  final String user;
  final String pass;
  final String confirmPass;

  final double salary;

  final List<RegisterEmployee> employee;

  final bool loadingCreate;
  final bool loadingDelete;
  final bool loadingUpdate;
  final bool success;
  final bool failure;
  final bool delSuccess;
  final bool delFailure;

  RegEmployeeState copyWith({
    String? name,
    String? lastNames,
    String? dni,
    String? phone,
    String? eMail,
    String? user,
    String? pass,
    String? confirmPass,
    double? salary,
    List<RegisterEmployee>? employee,
    bool? loadingCreate,
    bool? loadingDelete,
    bool? loadingUpdate,
    bool? success,
    bool? failure,
    bool? delSuccess,
    bool? delFailure,
  }) =>
      RegEmployeeState(
        name: name ?? this.name,
        lastNames: lastNames ?? this.lastNames,
        dni: dni ?? this.dni,
        phone: phone ?? this.dni,
        eMail: eMail ?? this.eMail,
        user: user ?? this.user,
        pass: pass ?? this.pass,
        confirmPass: confirmPass ?? this.confirmPass,
        salary: salary ?? this.salary,
        employee: employee ?? this.employee,
        loadingCreate: loadingCreate ?? this.loadingCreate,
        loadingDelete: loadingDelete ?? this.loadingDelete,
        loadingUpdate: loadingUpdate ?? this.loadingUpdate,
        success: success ?? this.success,
        failure: failure ?? this.failure,
        delSuccess: delSuccess ?? this.delSuccess,
        delFailure: delFailure ?? this.delFailure,
      );

  @override
  List<Object> get props => [
        name,
        lastNames,
        dni,
        phone,
        eMail,
        user,
        pass,
        confirmPass,
        salary,
        employee,
        loadingCreate,
        loadingDelete,
        loadingUpdate,
        success,
        failure,
        delSuccess,
        delFailure,
      ];
}
