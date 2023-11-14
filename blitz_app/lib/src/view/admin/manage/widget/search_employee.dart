import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../style/style.dart';

class SearchEmployee extends StatefulWidget {
  const SearchEmployee({
    super.key,
    required this.size,
    this.label,
    required this.onChanged,
  });

  final Size size;
  final String? label;
  final Function(String)? onChanged;

  @override
  _SearchEmployeeState createState() => _SearchEmployeeState(
        size: size,
        label: label,
        onChanged: onChanged,
      );
}

class _SearchEmployeeState extends State<SearchEmployee> {
  _SearchEmployeeState({
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
      child: Padding(
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
