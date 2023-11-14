part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.userName = 'user',
    this.pass = 'pass',
    user,
    this.loading = false,
  }) : user = const User(user: 'user', pass: 'pass');
  final String userName;
  final String pass;
  final User user;
  final bool loading;

  AuthState copyWith({
    String? userName,
    String? pass,
    User? user,
    bool? loading,
  }) =>
      AuthState(
        userName: userName ?? this.userName,
        pass: pass ?? this.pass,
        user: user ?? this.user,
        loading: loading ?? this.loading,
      );

  @override
  List<Object?> get props => [
        user,
        userName,
        pass,
        loading,
      ];
}
