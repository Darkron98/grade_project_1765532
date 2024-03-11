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
  });

  final Size size;

  final String? label;

  final Function(String)? onChanged;

  final void Function()? onPressed;

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

  @override
  void initState() {
    super.initState();

    size = super.widget.size;

    label = super.widget.label;

    onChanged = super.widget.onChanged;

    onPressed = super.widget.onPressed;

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
      child: BlocBuilder<OrderBloc, OrderState>(
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
