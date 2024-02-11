class AuthResp {
  const AuthResp({
    required this.user,
    required this.rol,
    required this.token,
    required this.statusCode,
  });

  final String user;
  final int rol;
  final String token;
  final String statusCode;

  AuthResp copyWith({
    String? user,
    int? rol,
    String? token,
    String? statusCode,
  }) =>
      AuthResp(
        user: user ?? this.user,
        rol: rol ?? this.rol,
        token: token ?? this.token,
        statusCode: statusCode ?? this.statusCode,
      );
}
