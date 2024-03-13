part of 'auth_bloc.dart';

class AuthState extends Equatable {
  AuthState({
    this.userName = '',
    this.pass = '',
    this.loading = false,
    this.success = false,
    this.failure = false,
    remain,
  }) : remain = Preferences().remain;

  final String userName;
  final String pass;

  final bool loading;
  final bool success;
  final bool failure;
  final bool remain;

  AuthState copyWith({
    String? userName,
    String? pass,
    User? user,
    bool? loading,
    bool? success,
    bool? failure,
    bool? remain,
  }) =>
      AuthState(
        userName: userName ?? this.userName,
        pass: pass ?? this.pass,
        loading: loading ?? this.loading,
        success: success ?? this.success,
        failure: failure ?? this.failure,
        remain: remain ?? this.remain,
      );

  @override
  List<Object?> get props => [
        userName,
        pass,
        loading,
        success,
        failure,
        remain,
      ];
}
