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
                title: const Text('Estas seguro?'),
                content: const Text('Deseas cancelar el pedido?'),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor:
                            const Color.fromARGB(255, 86, 50, 136)),
                    onPressed: state.loadingOrder
                        ? null
                        : () {
                            BlocProvider.of<OrderBloc>(context).add(
                                UpdateOrder(index: i, operation: 'cancel'));
                            Navigator.of(context).pop();
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
                content: const Text('Desea tomar este pedido?'),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor:
                            const Color.fromARGB(255, 86, 50, 136)),
                    onPressed: state.loadingOrder
                        ? null
                        : () {
                            BlocProvider.of<OrderBloc>(context)
                                .add(UpdateOrder(index: i, operation: 'take'));
                            Navigator.of(context).pop();
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
                content: const Text('El pedido sera marcado como entregado'),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor:
                            const Color.fromARGB(255, 86, 50, 136)),
                    onPressed: state.loadingOrder
                        ? null
                        : () {
                            BlocProvider.of<OrderBloc>(context)
                                .add(UpdateOrder(index: i, operation: 'ship'));
                            Navigator.of(context).pop();
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
