import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project_1765532/src/bloc/auth/auth_bloc.dart';
import 'package:grade_project_1765532/src/style/color/palette.dart';
import 'package:remixicon/remixicon.dart';

class CustomMultiLineText extends StatefulWidget {
  const CustomMultiLineText({
    super.key,
    required this.size,
    this.label,
    required this.onChanged,
    this.maxLines,
  });
  final Size size;
  final String? label;
  final Function(String)? onChanged;
  final int? maxLines;

  @override
  _CustomMultiLineTextState createState() => _CustomMultiLineTextState(
        size: size,
        label: label,
        onChanged: onChanged,
        maxLines: maxLines,
      );
}

class _CustomMultiLineTextState extends State<CustomMultiLineText> {
  _CustomMultiLineTextState({
    required this.onChanged,
    required this.size,
    this.label,
    this.maxLines,
  });
  final FocusNode _focusNode = FocusNode();
  final Size size;
  final String? label;
  final Function(String)? onChanged;
  final int? maxLines;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {});
    });
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
            maxLines: maxLines,
            textAlign: TextAlign.left,
            focusNode: _focusNode,
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
              labelText: label,
              labelStyle: TextStyle(
                color: _focusNode.hasFocus
                    ? ColorPalette.textColor
                    : ColorPalette.unFocused,
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: ColorPalette.unFocused)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: ColorPalette.primary)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
          ),
        ),
      ),
    );
  }
}
