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
    this.onPressed,
    this.controller,
    this.onSubmitted,
  });

  final Size size;

  final String? label;

  final Function(String)? onChanged;

  final void Function()? onPressed;

  final TextEditingController? controller;

  final void Function(String)? onSubmitted;

  @override
  SearchTextFieldState createState() => SearchTextFieldState();
}

class SearchTextFieldState extends State<SearchTextField> {
  SearchTextFieldState();

  final FocusNode _focusNode = FocusNode();

  late Size size;

  late String? label;

  late Function(String)? onChanged;

  late void Function()? onPressed;

  late TextEditingController? controller;

  late void Function(String)? onSubmitted;

  @override
  void initState() {
    super.initState();

    size = super.widget.size;

    label = super.widget.label;

    onChanged = super.widget.onChanged;

    onPressed = super.widget.onPressed;

    controller = super.widget.controller;

    onSubmitted = super.widget.onSubmitted;

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
      child: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: TextField(
          textAlign: TextAlign.left,
          focusNode: _focusNode,
          cursorColor: ColorPalette.textColor,
          controller: controller,
          cursorWidth: 1.5,
          cursorRadius: const Radius.circular(0.5),
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          style: TextStyle(
            color: _focusNode.hasFocus
                ? ColorPalette.textColor
                : ColorPalette.unFocused,
          ),
          decoration: InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsets.all(3),
                child: GestureDetector(
                  onTap: _focusNode.hasFocus ? null : onPressed,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: _focusNode.hasFocus
                            ? ColorPalette.lightBg
                            : ColorPalette.primary,
                        borderRadius: BorderRadius.circular(40)),
                    child: Icon(
                      Remix.search_line,
                      color: _focusNode.hasFocus
                          ? ColorPalette.unFocused
                          : ColorPalette.textColor,
                    ),
                  ),
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
                  borderSide: const BorderSide(color: ColorPalette.unFocused)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: ColorPalette.primary)),
              contentPadding: const EdgeInsets.only(left: 20, right: 20)),
        ),
      ),
    );
  }
}
