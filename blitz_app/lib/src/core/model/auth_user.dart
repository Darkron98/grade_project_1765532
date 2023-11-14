class User {
  const User({
    required this.user,
    required this.pass,
  });
  final String user;
  final String pass;

  User copyWith({String? user, String? pass}) => User(
        user: user ?? this.user,
        pass: pass ?? this.pass,
      );
}
