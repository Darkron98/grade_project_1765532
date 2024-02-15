part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.lastName = '',
    this.userName = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.password = '',
    this.confirmationPass = '',
    this.loading = false,
    this.failure = false,
    this.success = false,
  });

  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmationPass;
  final String lastName;
  final String userName;
  final bool success;
  final bool failure;
  final bool loading;

  RegisterState copyWith({
    String? confirmationPass,
    String? name,
    String? email,
    String? phone,
    String? password,
    String? lastName,
    String? userName,
    bool? loading,
    bool? success,
    bool? failure,
  }) =>
      RegisterState(
        confirmationPass: confirmationPass ?? this.confirmationPass,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        lastName: lastName ?? this.lastName,
        userName: userName ?? this.userName,
        loading: loading ?? this.loading,
        success: success ?? this.success,
        failure: failure ?? this.failure,
      );

  @override
  List<Object> get props => [
        confirmationPass,
        name,
        email,
        phone,
        password,
        userName,
        lastName,
        loading,
        failure,
        success,
      ];
}
