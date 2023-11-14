part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState(
      {this.name = 'name',
      this.email = 'email',
      this.phone = '0000',
      this.password = 'pass',
      registerInfo,
      this.confirmationPass = ''})
      : registerInfo = const RegisterInfo(
          name: 'name',
          email: 'email',
          phone: '0000',
          password: 'pass',
        );
  final RegisterInfo registerInfo;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmationPass;

  RegisterState copyWith({
    RegisterInfo? registerInfo,
    String? confirmationPass,
    String? name,
    String? email,
    String? phone,
    String? password,
  }) =>
      RegisterState(
        registerInfo: registerInfo ?? this.registerInfo,
        confirmationPass: confirmationPass ?? this.confirmationPass,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        password: password ?? this.password,
      );

  @override
  List<Object> get props => [
        registerInfo,
        confirmationPass,
        name,
        email,
        phone,
        password,
      ];
}
