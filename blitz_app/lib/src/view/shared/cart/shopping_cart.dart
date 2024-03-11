import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:remixicon/remixicon.dart';

import '../../../bloc/bloc.dart';
import '../../../style/style.dart';
import '../../widgets/snackbar.dart';
import '../login/widget/widgets.dart';

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
                CheckInButton(
                  size: size,
                  onPressed: () => orderAlert(context),
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
                      'Nada agregado aun.',
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

class InstructionsPanel extends StatelessWidget {
  const InstructionsPanel({
    super.key,
  });

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
                onChanged: (value) => BlocProvider.of<OrderBloc>(context)
                    .add(TypeObservations(value)),
                cursorColor: ColorPalette.textColor,
                style: const TextStyle(color: ColorPalette.textColor),
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Observaciones',
                  hintStyle: TextStyle(color: ColorPalette.unFocused),
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
          height: 225,
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
                '\$ ${MoneyFormatter(amount: state.orderItems[i].unitPrice).output.withoutFractionDigits}',
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
                        onTap: () => BlocProvider.of<OrderBloc>(context)
                            .add(ModifyItemQuatity(index: i, operation: 'add')),
                        child: const Icon(
                          Remix.add_fill,
                          color: ColorPalette.cartIcons,
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
                content: const Text('Guardar todo y terminar?'),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor:
                            const Color.fromARGB(255, 86, 50, 136)),
                    onPressed: state.loadingOrder
                        ? null
                        : () {
                            BlocProvider.of<OrderBloc>(context)
                                .add(SubmmitOrder());
                            Navigator.pop(context);
                          },
                    child: const Text('Aceptar'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: ColorPalette.primary),
                    onPressed: state.loadingOrder
                        ? null
                        : () {
                            Navigator.of(context).pop();
                          },
                    child: const Text('Cerrar'),
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
