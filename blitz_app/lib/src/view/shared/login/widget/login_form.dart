import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project_1765532/src/bloc/auth/auth_bloc.dart';
import 'package:grade_project_1765532/src/style/color/palette.dart';
import 'package:remixicon/remixicon.dart';

class LoginFormField extends StatefulWidget {
  const LoginFormField({
    super.key,
    required this.size,
    this.pass,
    this.label,
    required this.onChanged,
  });
  final bool? pass;
  final Size size;
  final String? label;
  final Function(String)? onChanged;

  @override
  _LoginFormFieldState createState() => _LoginFormFieldState(
        size: size,
        pass: pass,
        label: label,
        obscure: pass ?? false,
        onChanged: onChanged,
      );
}

class _LoginFormFieldState extends State<LoginFormField> {
  _LoginFormFieldState({
    required this.onChanged,
    required this.size,
    this.pass,
    this.label,
    required this.obscure,
  });
  final FocusNode _focusNode = FocusNode();
  final bool? pass;
  final Size size;
  final String? label;
  bool obscure = false;
  final Function(String)? onChanged;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  void obscurePass() {
    this.obscure = !this.obscure;
    setState(() {});
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
            selectionColor: Color.fromARGB(255, 141, 56, 56),
            selectionHandleColor: ColorPalette.primary),
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.only(
            left: 40,
            right: 40,
            bottom: 15,
          ),
          child: TextField(
            textAlign: TextAlign.left,
            focusNode: _focusNode,
            obscureText: obscure,
            cursorColor: ColorPalette.textColor,
            cursorWidth: 1.5,
            cursorRadius: const Radius.circular(0.5),
            onChanged: onChanged,
            style: TextStyle(
              color: _focusNode.hasFocus
                  ? ColorPalette.textColor
                  : ColorPalette.unFocused,
            ),
            decoration: InputDecoration(
                suffixIcon: pass ?? false
                    ? IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          if (pass ?? false) {
                            obscurePass();
                          }
                        },
                        icon: Icon(
                          obscure ? Remix.eye_off_line : Remix.eye_line,
                          size: 22.5,
                          color: ColorPalette.unFocused,
                          weight: 0.5,
                        ),
                      )
                    : null,
                labelText: label,
                labelStyle: TextStyle(
                  color: _focusNode.hasFocus
                      ? ColorPalette.textColor
                      : ColorPalette.unFocused,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide:
                        const BorderSide(color: ColorPalette.unFocused)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: ColorPalette.primary)),
                contentPadding: const EdgeInsets.only(left: 20, right: 20)),
          ),
        ),
      ),
    );
  }
}
