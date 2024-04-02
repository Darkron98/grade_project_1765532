import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project_1765532/src/bloc/menuPrefs/menu_prefs_bloc.dart';
import 'package:remixicon/remixicon.dart';

import '../../../style/style.dart';

class CustomModal extends StatefulWidget {
  const CustomModal({
    super.key,
    required this.size,
    this.label,
    required this.bloc,
  });

  final Size size;
  final String? label;
  final MenuPrefsBloc bloc;

  @override
  CustomModalState createState() => CustomModalState();
}

class CustomModalState extends State<CustomModal> {
  CustomModalState();

  final FocusNode _focusNode = FocusNode();

  late Size size;
  late String? label;
  late MenuPrefsBloc bloc;
  late String selectCategory = '';

  bool deployed = false;

  @override
  void initState() {
    super.initState();
    size = super.widget.size;
    label = super.widget.label;
    bloc = super.widget.bloc;
    _focusNode.addListener(
      () {
        setState(() {});
        if (_focusNode.hasFocus) {
          _focusNode.unfocus();
          if (bloc.state.categories.isEmpty) {
            bloc.add(LoadCategories());
          }
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            barrierColor: Colors.transparent,
            isScrollControlled: false,
            enableDrag: false,
            context: context,
            builder: (context) => BlocProvider.value(
              value: bloc,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 250,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        color: ColorPalette.textColor),
                    child: BlocBuilder<MenuPrefsBloc, MenuPrefsState>(
                      builder: (context, state) {
                        return bloc.state.loadingCategories
                            ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  SizedBox(),
                                  SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: CircularProgressIndicator(
                                          color: ColorPalette.primary,
                                          strokeWidth: 6)),
                                  SizedBox()
                                ],
                              )
                            : ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, i) => ListTile(
                                      leading: const Icon(
                                        Remix.radio_button_line,
                                        color: ColorPalette.primary,
                                      ),
                                      title: Text(
                                        bloc.state.categories[i].categoryName,
                                        style: const TextStyle(
                                            color: ColorPalette.lightBg),
                                      ),
                                      onTap: () {
                                        var category = bloc.state.categories[i];
                                        bloc.add(SelectCategory(
                                            category.categoryId,
                                            category.categoryName));
                                        setState(() {
                                          selectCategory =
                                              category.categoryName;
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                separatorBuilder: (context, i) =>
                                    const Divider(),
                                itemCount: bloc.state.categories.length);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ).then((value) {
            setState(() {
              deployed = false;
            });
          });
          deployed = true;
        }
      },
    );
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
      child: BlocBuilder<MenuPrefsBloc, MenuPrefsState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.only(
            left: 40,
            right: 40,
            bottom: 15,
          ),
          child: TextField(
            readOnly: true,
            textAlign: TextAlign.left,
            focusNode: _focusNode,
            cursorColor: ColorPalette.textColor,
            cursorWidth: 1.5,
            cursorRadius: const Radius.circular(0.5),
            style: TextStyle(
              color: _focusNode.hasFocus
                  ? ColorPalette.textColor
                  : ColorPalette.unFocused,
            ),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                splashColor: Colors.transparent,
                onPressed: () {},
                icon: Icon(
                  deployed ? Remix.arrow_down_s_fill : Remix.arrow_right_s_fill,
                  size: 22.5,
                  color: deployed
                      ? ColorPalette.textColor
                      : ColorPalette.unFocused,
                  weight: 0.5,
                ),
              ),
              hintText: selectCategory.isEmpty ? label : selectCategory,
              hintStyle: TextStyle(
                color:
                    deployed ? ColorPalette.textColor : ColorPalette.unFocused,
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                      color: deployed
                          ? ColorPalette.primary
                          : ColorPalette.unFocused)),
              contentPadding: const EdgeInsets.only(left: 20, right: 20),
            ),
          ),
        ),
      ),
    );
  }
}
