// ignore_for_file: unused_element, library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project_1765532/src/bloc/menuPrefs/menu_prefs_bloc.dart';
import 'package:grade_project_1765532/src/core/service/pick_img.dart';
import 'package:grade_project_1765532/src/style/color/palette.dart';

import 'package:grade_project_1765532/src/view/shared/login/widget/login_button.dart';
import 'package:grade_project_1765532/src/view/shared/login/widget/login_form.dart';
import 'package:grade_project_1765532/src/view/widgets/snackbar.dart';
import 'package:remixicon/remixicon.dart';

import 'custom_dropdown.dart';

void createDishModal(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  var bloc = BlocProvider.of<MenuPrefsBloc>(context);
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => BlocProvider.value(
      value: bloc,
      child: BlocBuilder<MenuPrefsBloc, MenuPrefsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Container(
              decoration: BoxDecoration(
                  color: ColorPalette.background,
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                              color: ColorPalette.lightBg,
                              borderRadius: BorderRadius.circular(2.5)),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Registrar platillo',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.textColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          color: ColorPalette.darkBg,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 600,
                      child: PageView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          _Page1(size: size),
                          _Page2(size: size),
                        ],
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

class _Page1 extends StatelessWidget {
  const _Page1({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            const RequiredField(),
            const SizedBox(height: 15),
            LoginFormField(
                size: MediaQuery.of(context).size,
                onChanged: (value) => BlocProvider.of<MenuPrefsBloc>(context)
                    .add(DishName(value)),
                label: 'Platillo'),
            const SizedBox(height: 5),
            LoginFormField(
              size: size,
              onChanged: (value) => BlocProvider.of<MenuPrefsBloc>(context)
                  .add(Description(value)),
              label: 'Descripción',
            ),
            const SizedBox(height: 5),
            LoginFormField(
                size: MediaQuery.of(context).size,
                onChanged: (value) => BlocProvider.of<MenuPrefsBloc>(context)
                    .add(Price(double.parse(value))),
                label: 'Precio unitario'),
            const SizedBox(height: 5),
            BlocBuilder<MenuPrefsBloc, MenuPrefsState>(
              builder: (context, state) {
                return CustomModal(
                  size: size,
                  label: state.selectCategoryName.isEmpty
                      ? 'Categoria'
                      : state.selectCategoryName,
                  bloc: BlocProvider.of<MenuPrefsBloc>(context),
                );
              },
            ),
          ],
        ),
        const Icon(
          Remix.arrow_right_s_line,
          size: 100,
          color: ColorPalette.lightBg,
        ),
      ],
    );
  }
}

class RequiredField extends StatelessWidget {
  const RequiredField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        Text(
          'Campos obligatorios',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14,
            color: ColorPalette.unFocused,
          ),
        ),
        SizedBox(),
        SizedBox(),
      ],
    );
  }
}

class _Page2 extends StatelessWidget {
  const _Page2({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            ImagePickerWidget(
                onImageSelected: (imgPath) =>
                    BlocProvider.of<MenuPrefsBloc>(context)
                        .add(PickImage(imgPath))),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Selecciona una foto (opcional)',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 15,
                color: ColorPalette.unFocused,
              ),
            ),
          ],
        ),
        BlocBuilder<MenuPrefsBloc, MenuPrefsState>(
          builder: (context, state) {
            return BlocListener<MenuPrefsBloc, MenuPrefsState>(
              listener: (context, state) {
                if (state.success) {
                  Navigator.pop(context);
                  customSnackbar(context,
                      message: 'Platillo guardado!', type: 'ok');
                } else if (state.success) {
                  customSnackbar(context,
                      message: 'Ups! algo salio mal', type: 'error');
                }
              },
              child: CustomButton(
                  size: MediaQuery.of(context).size,
                  onPressed: state.loadingCreate
                      ? null
                      : () => BlocProvider.of<MenuPrefsBloc>(context)
                          .add(Submitt()),
                  color: ColorPalette.primary,
                  child: state.loadingCreate
                      ? const SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            color: ColorPalette.primary,
                          ),
                        )
                      : const Text('Guardar')),
            );
          },
        ),
      ],
    );
  }
}

class DescriptionPanel extends StatelessWidget {
  const DescriptionPanel({
    super.key,
    this.onChanged,
  });

  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: ColorPalette.darkBg,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            cursorColor: ColorPalette.textColor,
            style: const TextStyle(color: ColorPalette.textColor),
            maxLines: 4,
            onChanged: onChanged,
            decoration: const InputDecoration(
              hintText: 'Descripcion',
              hintStyle: TextStyle(color: ColorPalette.unFocused),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

class ImagePickerWidget extends StatefulWidget {
  final Function(String) onImageSelected;

  const ImagePickerWidget({Key? key, required this.onImageSelected})
      : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  String imgPath = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.7,
      height: ((size.width * 0.7) * 2) / 3,
      child: Stack(
        children: [
          Container(
            width: size.width * 0.7,
            height: ((size.width * 0.7) * 2) / 3,
            decoration: BoxDecoration(
                color: ColorPalette.textColor,
                borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imgPath.isNotEmpty
                  ? Image.file(
                      File(imgPath),
                      fit: BoxFit.cover,
                    )
                  : const Image(
                      image: AssetImage('assets/placeholder.png'),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              child: Container(
                width: size.width * 0.7,
                height: (size.width * 0.7) / 6,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(146, 53, 53, 53),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Icon(
                  Remix.image_edit_fill,
                  color: ColorPalette.textColor,
                  size: (size.width * 0.7) / 7,
                ),
              ),
              onTap: () async {
                var pickedImage = await getImage();
                if (pickedImage != null) {
                  setState(() {
                    imgPath = pickedImage;
                  });
                  widget.onImageSelected(imgPath);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
