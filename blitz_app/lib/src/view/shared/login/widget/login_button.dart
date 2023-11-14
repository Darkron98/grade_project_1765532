import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project_1765532/src/bloc/auth/auth_bloc.dart';
import 'package:grade_project_1765532/src/style/color/palette.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.size, required this.onPressed});
  final Size size;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.only(
          left: 40,
          right: 40,
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromHeight(45),
              backgroundColor: ColorPalette.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: onPressed,
            child: const Text(
              'Ingresar',
              style: TextStyle(color: ColorPalette.textColor),
            ),
          ),
        ),
      ),
    );
  }
}
