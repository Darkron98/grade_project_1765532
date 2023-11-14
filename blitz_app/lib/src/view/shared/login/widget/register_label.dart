import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project_1765532/src/bloc/auth/auth_bloc.dart';

import '../../../../style/style.dart';

class RegisterLabel extends StatelessWidget {
  const RegisterLabel({
    super.key,
    required this.pageController,
  });
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.only(bottom: 25, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'No tienes cuenta? ',
              style: TextStyle(color: ColorPalette.textColor),
            ),
            GestureDetector(
                onTap: () {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  //BlocProvider.of<AuthBloc>(context).add(const GoRegister(1));
                },
                child: const Text(
                  'Registrate!',
                  style: TextStyle(
                    color: ColorPalette.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
