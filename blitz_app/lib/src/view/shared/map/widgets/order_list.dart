// ignore_for_file: use_build_context_synchronously

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grade_project_1765532/src/core/logic/shared_preferences.dart';
import 'package:grade_project_1765532/src/view/shared/cart/shopping_cart.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../bloc/bloc.dart';
import '../../../../core/logic/functions.dart';
import '../../../../style/style.dart';
import '../../../widgets/snackbar.dart';
import 'widgets.dart';

class OrderList extends StatefulWidget {
  const OrderList({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  late int selectIndex;

  void setIndex(int i) {
    selectIndex = i;
    setState(() {});
  }

  @override
  void initState() {
    selectIndex = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        /* if (state.orders.isEmpty && !state.loadingOrders) {
          BlocProvider.of<OrderBloc>(context).add(GetOrderList());
        } */
        return BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state.shippingSuccess) {
              customSnackbar(context, message: 'Pedido entregado!', type: 'ok');
              setIndex(-1);
            } else if (state.cancelSuccess) {
              customSnackbar(context,
                  message: 'Pedido cancelado :c', type: 'ok');
              setIndex(-1);
            } else if (state.takeSuccess) {
              customSnackbar(context, message: 'Pedido tomado!', type: 'ok');
              setIndex(-1);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              height: widget.size.height * 0.57,
              child: state.orders.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.orders.length,
                        separatorBuilder: (context, i) =>
                            const SizedBox(height: 15),
                        itemBuilder: (context, i) => Container(
                          decoration: BoxDecoration(
                              color: ColorPalette.lightBg,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (state.orders[i].items.isEmpty) {
                                    BlocProvider.of<OrderBloc>(context)
                                        .add(GetOrderItems(i));
                                  }
                                  setIndex(selectIndex == i ? -1 : i);
                                },
                                child: ListTile(
                                  splashColor: Colors.transparent,
                                  leading: selectIndex == i &&
                                          Preferences().rol != 3
                                      ? BlocBuilder<MapBloc, MapState>(
                                          builder: (context, mapState) {
                                            return GestureDetector(
                                              onTap: () async {
                                                bool serviceEnabled =
                                                    await Geolocator
                                                        .isLocationServiceEnabled();
                                                if (serviceEnabled) {
                                                  double lat =
                                                      await getLocationLat();
                                                  double long =
                                                      await getLocationLong();

                                                  BlocProvider.of<MapBloc>(
                                                          context)
                                                      .add(SetSrcLocation(
                                                          lat, long));

                                                  BlocProvider.of<MapBloc>(
                                                          context)
                                                      .add(SetLocation(
                                                          state.orders[i].lat,
                                                          state.orders[i].lng));
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const NavigationWidget()));
                                                } else {
                                                  locationIncactiveAlert(
                                                      context);
                                                }
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: ColorPalette.primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Icon(
                                                  Remix.user_location_line,
                                                  size: 30,
                                                  color: ColorPalette.textColor,
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(top: 9),
                                          child: Icon(
                                            Remix.shopping_basket_line,
                                            color:
                                                i == 0 && Preferences().rol != 3
                                                    ? ColorPalette.cartIcons
                                                    : ColorPalette.unFocused,
                                          ),
                                        ),
                                  title: Row(
                                    children: [
                                      const Icon(
                                        Remix.phone_fill,
                                        color: ColorPalette.background,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        state.orders[i].owner,
                                        style: const TextStyle(
                                          color: ColorPalette.textColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Remix.map_pin_2_fill,
                                            color: ColorPalette.background,
                                          ),
                                          const SizedBox(width: 5),
                                          SizedBox(
                                            width: selectIndex == i ? 190 : 140,
                                            child: Tooltip(
                                              message: state
                                                  .orders[i].addressName
                                                  .split(',')[0],
                                              child: Text(
                                                state.orders[i].addressName
                                                    .split(',')[0],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: ColorPalette.textColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Icon(
                                    selectIndex == i
                                        ? Remix.arrow_drop_up_line
                                        : Remix.arrow_drop_down_line,
                                    size: 40,
                                    color: ColorPalette.textColor,
                                  ),
                                ),
                              ),
                              if (state.loadingOrders &&
                                  state.orders.isNotEmpty &&
                                  selectIndex == i) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: const Divider(
                                    color: ColorPalette.darkBg,
                                  ),
                                ),
                                const SizedBox(
                                  height: 260,
                                  width: double.infinity,
                                  child: Center(
                                    child: SizedBox(
                                      width: 75,
                                      height: 75,
                                      child: CircularProgressIndicator(
                                        color: ColorPalette.primary,
                                        strokeWidth: 6,
                                      ),
                                    ),
                                  ),
                                )
                              ] else if (selectIndex == i) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: const Divider(
                                    color: ColorPalette.darkBg,
                                  ),
                                ),
                                if (state.orders[i].items.isNotEmpty) ...[
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      height: 40 *
                                          state.orders[i].items.length
                                              .toDouble(),
                                      decoration: BoxDecoration(
                                          color: ColorPalette.background,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: state.orders[i].items.length,
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                ItemField(
                                          name: state
                                              .orders[i].items[index].itemDesc,
                                          value: state
                                              .orders[i].items[index].quantity
                                              .toString(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: ItemField(
                                      name: 'Total',
                                      value:
                                          '\$ ${MoneyFormatter(amount: state.orders[i].totalPrice).output.withoutFractionDigits}',
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: ItemField(
                                      name: 'Creado',
                                      value: formatDate(state.orders[i].date),
                                    ),
                                  ),
                                ],
                                if (state
                                    .orders[i].observations.isNotEmpty) ...[
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: const Divider(
                                      color: ColorPalette.darkBg,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          'Observaciones:',
                                          style: TextStyle(
                                            color: ColorPalette.textColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(state.orders[i].observations,
                                            style: const TextStyle(
                                                color: ColorPalette.textColor,
                                                fontSize: 15)),
                                        const SizedBox(),
                                      ],
                                    ),
                                  ),
                                ],
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: const Divider(
                                    color: ColorPalette.darkBg,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () => cancelAlert(context, i),
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: ColorPalette.cancelButton,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Icon(
                                          Remix.forbid_line,
                                          size: 35,
                                          color: ColorPalette.primary,
                                        ),
                                      ),
                                    ),
                                    if (state.orders[i].taken &&
                                        Preferences().rol != 3) ...[
                                      GestureDetector(
                                        onTap: () => shippAlert(context, i),
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: ColorPalette.takeButton,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Icon(
                                            Remix.user_follow_line,
                                            size: 35,
                                            color: ColorPalette.takeIcon,
                                          ),
                                        ),
                                      ),
                                    ] else if (Preferences().rol != 3) ...[
                                      GestureDetector(
                                        onTap: () => takeAlert(context, i),
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: ColorPalette.takeButton,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Icon(
                                            Remix.user_received_line,
                                            size: 35,
                                            color: ColorPalette.takeIcon,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 17),
                              ],
                            ],
                          ),
                        ),
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Column(
                          children: const [
                            Icon(
                              Remix.file_unknow_line,
                              size: 100,
                              color: ColorPalette.lightBg,
                            ),
                            Text(
                              'Sin ordenes aún\n(Actualizar)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorPalette.lightBg,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
