part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class TypeUser extends AuthEvent {
  const TypeUser(this.user);
  final String user;

  @override
  List<Object> get props => [user];
}

class TypePass extends AuthEvent {
  const TypePass(this.pass);
  final String pass;

  @override
  List<Object> get props => [pass];
}

class Submitted extends AuthEvent {
  const Submitted();

  @override
  List<Object> get props => [];
}
