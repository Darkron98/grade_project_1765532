import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/bloc.dart';
import '../../../../style/style.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton(
      {super.key, required this.size, required this.onPressed});
  final Size size;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 25),
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
              'Registrarse',
              style: TextStyle(
                color: ColorPalette.textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
