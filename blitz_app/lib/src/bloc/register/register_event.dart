part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class TypeName extends RegisterEvent {
  const TypeName(this.name);
  final String name;

  @override
  List<Object> get props => [name];
}

class TypeEmail extends RegisterEvent {
  const TypeEmail(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class TypePhone extends RegisterEvent {
  const TypePhone(this.phone);
  final String phone;

  @override
  List<Object> get props => [phone];
}

class TypePassword extends RegisterEvent {
  const TypePassword(this.pass);
  final String pass;

  @override
  List<Object> get props => [pass];
}

class ConfirmationPass extends RegisterEvent {
  const ConfirmationPass(this.confPass);
  final String confPass;

  @override
  List<Object> get props => [confPass];
}

class TypeLastName extends RegisterEvent {
  const TypeLastName(this.lasName);
  final String lasName;

  @override
  List<Object> get props => [lasName];
}

class TypeUserName extends RegisterEvent {
  const TypeUserName(this.userName);
  final String userName;

  @override
  List<Object> get props => [userName];
}

class ValidateForm extends RegisterEvent {
  const ValidateForm();

  @override
  List<Object> get props => [];
}

class ResetForm extends RegisterEvent {
  const ResetForm();
  @override
  List<Object> get props => [];
}
