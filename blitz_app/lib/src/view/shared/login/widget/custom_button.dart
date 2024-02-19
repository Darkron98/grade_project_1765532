
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project_1765532/src/bloc/auth/auth_bloc.dart';
import 'package:grade_project_1765532/src/style/color/palette.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.size,
      required this.onPressed,
      required this.color,
      required this.child});
  final Size size;
  final void Function()? onPressed;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.only(
          left: 40,
          right: 40,
        ),
        child: SizedBox(
          height: 45,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromHeight(45),
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: onPressed,
            child: child,
          ),
        ),
      ),
    );
  }
}
