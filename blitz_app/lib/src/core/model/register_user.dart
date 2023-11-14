class RegisterInfo {
  const RegisterInfo({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  final String name;
  final String email;
  final String phone;
  final String password;

  RegisterInfo copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
  }) =>
      RegisterInfo(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        password: password ?? this.password,
      );
}
