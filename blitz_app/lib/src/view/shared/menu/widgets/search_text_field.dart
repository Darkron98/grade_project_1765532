import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../bloc/bloc.dart';
import '../../../../style/style.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    required this.size,
    this.label,
    required this.onChanged,
  });

  final Size size;
  final String? label;
  final Function(String)? onChanged;

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState(
        size: size,
        label: label,
        onChanged: onChanged,
      );
}

class _SearchTextFieldState extends State<SearchTextField> {
  _SearchTextFieldState({
    required this.onChanged,
    required this.size,
    this.label,
  });
  final FocusNode _focusNode = FocusNode();

  final Size size;
  final String? label;

  final Function(String)? onChanged;

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
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: TextField(
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
                suffixIcon: IconButton(
                  splashColor: Colors.transparent,
                  onPressed: () {},
                  icon: const Icon(
                    Remix.search_line,
                    color: ColorPalette.unFocused,
                  ),
                ),
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
