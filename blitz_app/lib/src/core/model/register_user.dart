class RegisterInfo {
  const RegisterInfo({
    required this.lastName,
    required this.userName,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  final String name;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final String userName;

  RegisterInfo copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
    String? lastName,
    String? userName,
  }) =>
      RegisterInfo(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        userName: userName ?? this.userName,
        lastName: lastName ?? this.lastName,
      );
}
