import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project_1765532/src/bloc/bloc.dart';
import 'package:grade_project_1765532/src/core/logic/shared_preferences.dart';
import 'package:remixicon/remixicon.dart';

import '../../../style/style.dart';
import 'widgets/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const _Tittle(),
        BlocBuilder<MapBloc, MapState>(
          builder: (context, state) => OrderList(size: widget.size),
        ),
        /* BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return CustomButton(
              size: widget.size,
              color: state.loadingOrders
                  ? ColorPalette.unFocused
                  : ColorPalette.primary,
              onPressed: state.loadingOrders
                  ? null
                  : () {
                      BlocProvider.of<OrderBloc>(context).add(GetOrderList());
                    },
              child: state.loadingOrders
                  ? const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: ColorPalette.primary,
                      ),
                    )
                  : const Text(
                      'Actualizar',
                      style: TextStyle(color: ColorPalette.textColor),
                    ),
            );
          },
        ), */
        const SizedBox(),
      ],
    );
  }
}

class _Tittle extends StatelessWidget {
  const _Tittle();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 10,
                right: 10,
              ),
              child: Text(
                'Seguimiento',
                style: TextStyle(
                  color: ColorPalette.textColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    Preferences().rol == 3 ? 'Mis pedidos' : 'Pedidos',
                    style: const TextStyle(
                      color: ColorPalette.textColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15, top: 20),
                  child: GestureDetector(
                    onTap: state.loadingOrders
                        ? null
                        : () => BlocProvider.of<OrderBloc>(context)
                            .add(GetOrderList()),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: state.loadingOrders
                              ? ColorPalette.darkBg
                              : ColorPalette.primary,
                          borderRadius: BorderRadius.circular(25)),
                      child: state.loadingOrders
                          ? const Padding(
                              padding: EdgeInsets.all(10),
                              child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: ColorPalette.primary),
                            )
                          : const Icon(Remix.restart_line,
                              color: ColorPalette.textColor),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ],
    );
  }
}
