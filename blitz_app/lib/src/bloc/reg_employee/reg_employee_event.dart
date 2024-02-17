part of 'reg_employee_bloc.dart';

abstract class RegEmployeeEvent extends Equatable {
  const RegEmployeeEvent();

  @override
  List<Object> get props => [];
}

class TypeEmployeeName extends RegEmployeeEvent {
  const TypeEmployeeName(this.name);
  final String name;
  @override
  List<Object> get props => [name];
}

class TypeEmployeeLatName extends RegEmployeeEvent {
  const TypeEmployeeLatName(this.lastName);
  final String lastName;
  @override
  List<Object> get props => [lastName];
}

class TypeDNI extends RegEmployeeEvent {
  const TypeDNI(this.dni);
  final String dni;
  @override
  List<Object> get props => [dni];
}

class TypeEmployeePhone extends RegEmployeeEvent {
  const TypeEmployeePhone(this.phone);
  final String phone;
  @override
  List<Object> get props => [phone];
}

class TypeSalary extends RegEmployeeEvent {
  const TypeSalary(this.salary);
  final double salary;
  @override
  List<Object> get props => [salary];
}

class TypeEmployeeMail extends RegEmployeeEvent {
  const TypeEmployeeMail(this.mail);
  final String mail;
  @override
  List<Object> get props => [mail];
}

class TypeEmployeeUser extends RegEmployeeEvent {
  const TypeEmployeeUser(this.user);
  final String user;
  @override
  List<Object> get props => [user];
}

class TypeEmployeePass extends RegEmployeeEvent {
  const TypeEmployeePass(this.pass);
  final String pass;
  @override
  List<Object> get props => [pass];
}

class TypeEmployeeConfirm extends RegEmployeeEvent {
  const TypeEmployeeConfirm(this.conf);
  final String conf;
  @override
  List<Object> get props => [conf];
}

class InfoSubmmitt extends RegEmployeeEvent {
  const InfoSubmmitt();
  @override
  List<Object> get props => [];
}
