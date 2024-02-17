// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../../bloc/menuPrefs/menu_prefs_bloc.dart';
import '../../../../../core/service/pick_img.dart';
import '../../../../../style/style.dart';
import '../../../../shared/login/widget/widgets.dart';
import '../../../../widgets/snackbar.dart';
import 'custom_dropdown.dart';

void updateDishModal(BuildContext context) {
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
                          'Actualizar platillo',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.textColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    BlocBuilder<MenuPrefsBloc, MenuPrefsState>(
                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          width: double.infinity,
                          height: size.height * 0.85,
                          child: state.loadDishes
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
                              : Scaffold(
                                  backgroundColor: Colors.transparent,
                                  body: MenuDishList(size: size, state: state),
                                ),
                        );
                      },
                    ),
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

class MenuDishList extends StatefulWidget {
  const MenuDishList({
    super.key,
    required this.size,
    required this.state,
  });
  final MenuPrefsState state;
  final Size size;

  @override
  State<MenuDishList> createState() => _MenuDishListState();
}

class _MenuDishListState extends State<MenuDishList> {
  int index = -1;
  String imgPath = '';

  void selectIndex(int i) {
    setState(() {});
    if (i == index) {
      index = -1;
    } else {
      index = i;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, i) => Container(
                padding: EdgeInsets.only(
                    left: 10, right: 10, top: index == i ? 10 : 0),
                height: index == i ? 600 : ((80) * 2 / 3) + 20,
                decoration: BoxDecoration(
                    color: ColorPalette.lightBg,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: index == i
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: SizedBox(
                            width: 80,
                            height: ((80) * 2 / 3),
                            child: GestureDetector(
                              onTap: index == i
                                  ? () async {
                                      var pickedImage = await getImage();
                                      if (pickedImage != null) {
                                        setState(() {
                                          imgPath = pickedImage;
                                        });
                                        BlocProvider.of<MenuPrefsBloc>(context)
                                            .add(PickImage(imgPath));
                                      }
                                    }
                                  : null,
                              child: Stack(
                                children: [
                                  widget.state.imgPath.isNotEmpty && index == i
                                      ? Image.file(
                                          File(widget.state.imgPath),
                                          fit: BoxFit.cover,
                                        )
                                      : widget.state.menuDishes[i].labelImg
                                              .isEmpty
                                          ? const Image(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/placeholder.png'),
                                            )
                                          : FadeInImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(widget.state
                                                  .menuDishes[i].labelImg),
                                              placeholder: const AssetImage(
                                                  'assets/loading.gif'),
                                            ),
                                  if (index == i) ...[
                                    Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: const BoxDecoration(
                                          color: Color.fromARGB(106, 0, 0, 0)),
                                      child: Center(
                                        child: Icon(
                                          Remix.image_edit_fill,
                                          color: ColorPalette.textColor,
                                          size: (size.width * 0.7) / 7,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: widget.size.width * 0.4,
                          child: Tooltip(
                            decoration: BoxDecoration(
                                color: ColorPalette.textColor,
                                borderRadius: BorderRadius.circular(5)),
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.lightBg),
                            triggerMode: TooltipTriggerMode.tap,
                            message: widget.state.menuDishes[i].dishName,
                            child: Text(
                              widget.state.menuDishes[i].dishName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: 18, color: ColorPalette.textColor),
                            ),
                          ),
                        ),
                        BlocBuilder<MenuPrefsBloc, MenuPrefsState>(
                          builder: (context, state) {
                            return GestureDetector(
                              child: SizedBox(
                                width: 50,
                                child: Icon(
                                  index == i
                                      ? Remix.edit_box_fill
                                      : Remix.edit_box_line,
                                  size: 30,
                                  color: ColorPalette.primary,
                                ),
                              ),
                              onTap: () {
                                BlocProvider.of<MenuPrefsBloc>(context)
                                    .add(RestoreFields());
                                selectIndex(i);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    if (index == i) ...[
                      BlocBuilder<MenuPrefsBloc, MenuPrefsState>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.menuDishes[i].description,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      color: ColorPalette.textColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '\$ ${state.menuDishes[i].price}',
                                    style: const TextStyle(
                                        color: ColorPalette.textColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                      onTap: () {
                                        customAlert(context,
                                            state.menuDishes[i].dishId);
                                      },
                                      child: const Icon(
                                        Remix.delete_bin_7_line,
                                        color: ColorPalette.unFocused,
                                        size: 30,
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      //const Divider(),
                    ],
                    if (index == i) ...[
                      BlocBuilder<MenuPrefsBloc, MenuPrefsState>(
                        builder: (context, state) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    'Campos opcionales',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: ColorPalette.unFocused,
                                    ),
                                  ),
                                  SizedBox(),
                                  SizedBox(),
                                ],
                              ),
                              const SizedBox(height: 10),
                              LoginFormField(
                                  size: MediaQuery.of(context).size,
                                  onChanged: (value) =>
                                      BlocProvider.of<MenuPrefsBloc>(context)
                                          .add(DishName(value)),
                                  label: 'Platillo'),
                              const SizedBox(height: 5),
                              LoginFormField(
                                size: size,
                                onChanged: (value) =>
                                    BlocProvider.of<MenuPrefsBloc>(context)
                                        .add(Description(value)),
                                label: 'Descripción',
                              ),
                              const SizedBox(height: 5),
                              LoginFormField(
                                  size: MediaQuery.of(context).size,
                                  onChanged: (value) =>
                                      BlocProvider.of<MenuPrefsBloc>(context)
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
                                    bloc:
                                        BlocProvider.of<MenuPrefsBloc>(context),
                                  );
                                },
                              ),
                              const SizedBox(height: 2),
                              BlocBuilder<MenuPrefsBloc, MenuPrefsState>(
                                builder: (context, state) {
                                  return BlocListener<MenuPrefsBloc,
                                      MenuPrefsState>(
                                    listener: (context, state) {
                                      if (state.success) {
                                        customSnackbar(context,
                                            message: 'Informacion actualizada!',
                                            type: 'ok');
                                      } else if (state.success) {
                                        customSnackbar(context,
                                            message: 'Ups! algo salio mal',
                                            type: 'error');
                                      }
                                    },
                                    child: CustomButton(
                                      size: MediaQuery.of(context).size,
                                      onPressed: state.loadingCreate ||
                                              index < 0
                                          ? null
                                          : () =>
                                              BlocProvider.of<MenuPrefsBloc>(
                                                      context)
                                                  .add(Update(
                                                      state.menuDishes[index]
                                                          .dishId,
                                                      context)),
                                      color: ColorPalette.primary,
                                      child: state.loadingCreate
                                          ? const SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: CircularProgressIndicator(
                                                color: ColorPalette.primary,
                                              ),
                                            )
                                          : const Text('Actualizar'),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(),
                    ]
                  ],
                ),
              ),
          separatorBuilder: (context, i) => const SizedBox(height: 10),
          itemCount: widget.state.menuDishes.length),
    );
  }

  Future<dynamic> customAlert(BuildContext context, String id) {
    var bloc = BlocProvider.of<MenuPrefsBloc>(context);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: bloc,
          child: BlocBuilder<MenuPrefsBloc, MenuPrefsState>(
            builder: (context, state) {
              return AlertDialog(
                title: Text(state.loadingDelete ? 'Borrando' : 'Estas seguro?'),
                content: state.loadingDelete
                    ? SizedBox(
                        width: 40,
                        height: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            SizedBox(),
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: ColorPalette.primary,
                              ),
                            ),
                            SizedBox(),
                          ],
                        ),
                      )
                    : const Text('Deseas borrar este elemento?'),
                actions: [
                  BlocListener<MenuPrefsBloc, MenuPrefsState>(
                    listener: (context, state) {
                      if (state.delSuccess || state.delFailure) {
                        if (state.delSuccess) {
                          customSnackbar(context,
                              message: 'Platillo borrado :c', type: 'ok');
                          Navigator.pop(context);
                        } else if (state.delFailure) {
                          customSnackbar(context,
                              message: 'Ups! algo salio mal', type: 'error');
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(255, 86, 50, 136)),
                      onPressed: state.loadingDelete
                          ? null
                          : () {
                              BlocProvider.of<MenuPrefsBloc>(context)
                                  .add(Delete(id));
                            },
                      child: const Text('Aceptar'),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: ColorPalette.primary),
                    onPressed: state.loadingDelete
                        ? null
                        : () {
                            Navigator.of(context).pop();
                          },
                    child: const Text('Cerrar'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
