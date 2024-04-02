// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grade_project_1765532/src/core/logic/functions.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:remixicon/remixicon.dart';

import '../../../bloc/bloc.dart';
import '../../../style/style.dart';
import '../../widgets/snackbar.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state.success) {
              customSnackbar(
                context,
                message: 'Pedido creado correctamente!',
                type: 'ok',
              );
            } else if (state.failure) {
              customSnackbar(
                context,
                message: 'Ups! algo salio mal',
                type: 'error',
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CartTitle(),
              //const SizedBox(height: 20),
              if (state.orderItems.isNotEmpty) ...[
                const InstructionsPanel(),
                const CartItemList(),
                Column(
                  children: [
                    const Divider(color: ColorPalette.darkBg),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        const Text(
                          'Total',
                          style: TextStyle(
                            color: ColorPalette.textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(),
                        Text(
                          '\$ ${MoneyFormatter(amount: getOrderTotal(state.orderItems)).output.withoutFractionDigits}',
                          style: const TextStyle(
                            color: ColorPalette.textColor,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: ColorPalette.darkBg),
                  ],
                ),
                CheckInButton(
                  size: size,
                  onPressed: () async {
                    bool serviceEnabled =
                        await Geolocator.isLocationServiceEnabled();
                    if (serviceEnabled) {
                      orderAlert(context);
                    } else {
                      locationIncactiveAlert(context);
                    }
                  },
                ),
              ] else ...[
                Column(
                  children: const [
                    Icon(
                      Remix.shopping_basket_2_fill,
                      size: 100,
                      color: ColorPalette.lightBg,
                    ),
                    Text(
                      'Nada agregado aún.',
                      style: TextStyle(
                        color: ColorPalette.lightBg,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
              //const SizedBox(height: 20),

              //const SizedBox(height: 30),

              const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}

class CheckInButton extends StatelessWidget {
  const CheckInButton({super.key, required this.size, required this.onPressed});
  final Size size;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.175, right: size.width * 0.175, bottom: 0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromHeight(45),
                backgroundColor: state.loadingOrder
                    ? ColorPalette.unFocused
                    : ColorPalette.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: state.loadingOrder ? null : onPressed,
              child: state.loadingOrder
                  ? const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: ColorPalette.primary,
                      ),
                    )
                  : const Text(
                      'Terminar',
                      style: TextStyle(color: ColorPalette.textColor),
                    ),
            ),
          ),
        );
      },
    );
  }
}

class InstructionsPanel extends StatefulWidget {
  const InstructionsPanel({
    super.key,
  });

  @override
  State<InstructionsPanel> createState() => _InstructionsPanelState();
}

class _InstructionsPanelState extends State<InstructionsPanel> {
  FocusNode focus = FocusNode();

  @override
  void initState() {
    super.initState();
    focus.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
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
                focusNode: focus,
                onChanged: (value) => BlocProvider.of<OrderBloc>(context)
                    .add(TypeObservations(value)),
                cursorColor: ColorPalette.textColor,
                style: const TextStyle(color: ColorPalette.textColor),
                maxLines: null,
                decoration: InputDecoration(
                  suffixIcon: focus.hasFocus
                      ? IconButton(
                          splashColor: Colors.transparent,
                          icon: Icon(
                            Remix.check_line,
                            color: focus.hasFocus
                                ? ColorPalette.cartIcons
                                : ColorPalette.unFocused,
                            size: 25,
                          ),
                          onPressed: () {
                            focus.unfocus();
                          },
                        )
                      : null,
                  hintText: 'Observaciones',
                  hintStyle: const TextStyle(color: ColorPalette.unFocused),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CartItemList extends StatelessWidget {
  const CartItemList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: state.orderItems.length <= 3
              ? state.orderItems.length * 75
              : 3 * 75,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 15, right: 15),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, i) => ListTile(
              title: Text(
                state.orderItems[i].itemDesc,
                style: const TextStyle(
                  color: ColorPalette.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '\$ ${MoneyFormatter(amount: state.orderItems[i].unitPrice * state.orderItems[i].quantity).output.withoutFractionDigits}',
                style: const TextStyle(
                  color: ColorPalette.textColor,
                ),
              ),
              trailing: Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                    color: ColorPalette.darkBg,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () => BlocProvider.of<OrderBloc>(context)
                            .add(ModifyItemQuatity(index: i, operation: 'sub')),
                        child: Icon(
                          state.orderItems[i].quantity == 1
                              ? Remix.delete_bin_7_line
                              : Remix.subtract_fill,
                          color: state.orderItems[i].quantity == 1
                              ? Colors.grey
                              : ColorPalette.cartIcons,
                        ),
                      ),
                      Text(
                        state.orderItems[i].quantity.toString(),
                        style: const TextStyle(
                          color: ColorPalette.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: state.orderItems[i].quantity < 10
                            ? () => BlocProvider.of<OrderBloc>(context).add(
                                ModifyItemQuatity(index: i, operation: 'add'))
                            : null,
                        child: Icon(
                          Remix.add_fill,
                          color: state.orderItems[i].quantity < 10
                              ? ColorPalette.cartIcons
                              : ColorPalette.background,
                        ),
                      ),
                    ]),
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  image: NetworkImage(state.orderItems[i].labelImg),
                  width: 60,
                  placeholder: const AssetImage('assets/loading.gif'),
                ),
              ),
            ),
            itemCount: state.orderItems.length,
          ),
        );
      },
    );
  }
}

class CartTitle extends StatelessWidget {
  const CartTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 10,
            right: 10,
          ),
          child: Text(
            'Pedido',
            style: TextStyle(
              color: ColorPalette.textColor,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(),
      ],
    );
  }
}

Future<dynamic> orderAlert(BuildContext context) {
  var bloc = BlocProvider.of<OrderBloc>(context);
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocProvider.value(
        value: bloc,
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return BlocListener<OrderBloc, OrderState>(
              listener: (context, state) {
                if (state.success) {
                  Navigator.pop(context);
                }
              },
              child: AlertDialog(
                backgroundColor: ColorPalette.background,
                content: const Text(
                  'Guardar todo y terminar?',
                  style: TextStyle(color: ColorPalette.textColor),
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: ColorPalette.unFocused),
                    onPressed: state.loadingOrder
                        ? null
                        : () {
                            Navigator.of(context).pop();
                          },
                    child: const Text('Cerrar'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: ColorPalette.primary),
                    onPressed: state.loadingOrder
                        ? null
                        : () {
                            BlocProvider.of<OrderBloc>(context)
                                .add(SubmmitOrder());
                            Navigator.pop(context);
                          },
                    child: const Text('Aceptar'),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

Future<dynamic> locationIncactiveAlert(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: ColorPalette.background,
        title: const Text(
          'GPS desactivado!',
          style: TextStyle(color: ColorPalette.textColor),
        ),
        content: const Text(
          'Necesita activar el GPS.',
          style: TextStyle(color: ColorPalette.textColor),
        ),
        actions: [
          TextButton(
            style:
                TextButton.styleFrom(foregroundColor: ColorPalette.unFocused),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cerrar'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: ColorPalette.primary),
            onPressed: () {
              Navigator.pop(context);
              Geolocator.openLocationSettings();
            },
            child: const Text('activar'),
          ),
        ],
      );
    },
  );
}
