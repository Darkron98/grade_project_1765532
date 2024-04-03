import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/bloc.dart';
import '../../../../style/style.dart';

Future<dynamic> cancelAlert(BuildContext context, int i) {
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
                title: const Text(
                  'Estas seguro?',
                  style: TextStyle(color: ColorPalette.textColor),
                ),
                content: const Text(
                  'Deseas cancelar el pedido?',
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
                            BlocProvider.of<OrderBloc>(context).add(
                                UpdateOrder(index: i, operation: 'cancel'));
                            Navigator.of(context).pop();
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

Future<dynamic> takeAlert(BuildContext context, int i) {
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
                  'Desea tomar este pedido?',
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
                                .add(UpdateOrder(index: i, operation: 'take'));
                            Navigator.of(context).pop();
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

Future<dynamic> shippAlert(BuildContext context, int i) {
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
                  'El pedido sera marcado como entregado',
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
                                .add(UpdateOrder(index: i, operation: 'ship'));
                            Navigator.of(context).pop();
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
