import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../bloc/bloc.dart';
import '../../../../core/logic/functions.dart';
import '../../../../style/style.dart';
import '../../../widgets/snackbar.dart';

class FoodCards extends StatelessWidget {
  const FoodCards({
    super.key,
    required this.controller,
  });

  final SwiperController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state.itemAdded) {
              customSnackbar(context,
                  message: 'Se agrego al pedido!', type: 'ok');
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: SizedBox(
              height: 260,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: state.menu[state.selectedCategory].dishes.length > 1
                      ? BlocBuilder<OrderBloc, OrderState>(
                          builder: (context, state) {
                            return Swiper(
                              controller: controller,
                              layout: SwiperLayout.CUSTOM,
                              customLayoutOption: CustomLayoutOption(
                                  startIndex: state.startIndex, stateCount: 4)
                                ..addTranslate([
                                  const Offset(-350.0, 0.0),
                                  const Offset(-60, 0.0),
                                  const Offset(165, 0.0),
                                  const Offset(350, 0.0),
                                ])
                                ..addScale(
                                    [0.7, 1, 0.75, 0.7], Alignment.topRight)
                                ..addOpacity([0.1, 1, 0.4, 0.1]),
                              itemWidth: 210,
                              itemHeight: 260,
                              fade: 0.01,
                              physics: const BouncingScrollPhysics(),
                              loop: true,
                              viewportFraction: 0.4,
                              scale: 0.5,
                              itemCount: state
                                  .menu[state.selectedCategory].dishes.length,
                              itemBuilder: (BuildContext context, int i) =>
                                  Container(
                                width: 210,
                                height: 260,
                                decoration: BoxDecoration(
                                    color: ColorPalette.textColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            left: 10,
                                            right: 10,
                                            bottom: 2),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(7.5),
                                          child: SizedBox(
                                            width: 210,
                                            height: (210 * 2) / 3,
                                            child: FadeInImage(
                                              width: 210,
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                state
                                                    .menu[
                                                        state.selectedCategory]
                                                    .dishes[i]
                                                    .labelImg,
                                              ),
                                              placeholder: const AssetImage(
                                                  'assets/loading.gif'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 0),
                                      child: Text(
                                        state.menu[state.selectedCategory]
                                            .dishes[i].dishName,
                                        style: const TextStyle(
                                          color: ColorPalette.lightBg,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 0),
                                      child: Text(
                                        state.menu[state.selectedCategory]
                                            .dishes[i].description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: ColorPalette.lightBg,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10, left: 10),
                                          child: Text(
                                            '\$ ${MoneyFormatter(amount: state.menu[state.selectedCategory].dishes[i].price.toDouble()).output.withoutFractionDigits}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              if (validateDishQuantity(
                                                state
                                                    .menu[
                                                        state.selectedCategory]
                                                    .dishes[i]
                                                    .dishId,
                                                state.orderItems,
                                              )) {
                                                BlocProvider.of<OrderBloc>(
                                                        context)
                                                    .add(AddOrderItem(i));
                                              }
                                            },
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: validateDishQuantity(
                                                    state
                                                        .menu[state
                                                            .selectedCategory]
                                                        .dishes[i]
                                                        .dishId,
                                                    state.orderItems,
                                                  )
                                                      ? ColorPalette.primary
                                                      : ColorPalette.greyText,
                                                  borderRadius:
                                                      BorderRadius.circular(7)),
                                              child: const Icon(
                                                Remix.add_line,
                                                size: 20,
                                                color: ColorPalette.textColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 210,
                              height: 260,
                              decoration: BoxDecoration(
                                  color: ColorPalette.textColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 10,
                                          right: 10,
                                          bottom: 2),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(7.5),
                                        child: SizedBox(
                                          width: 210,
                                          height: (210 * 2) / 3,
                                          child: FadeInImage(
                                            width: 210,
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              state.menu[state.selectedCategory]
                                                  .dishes[0].labelImg,
                                            ),
                                            placeholder: const AssetImage(
                                                'assets/loading.gif'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 0),
                                    child: Text(
                                      state.menu[state.selectedCategory]
                                          .dishes[0].dishName,
                                      style: const TextStyle(
                                        color: ColorPalette.lightBg,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 0),
                                    child: Text(
                                      state.menu[state.selectedCategory]
                                          .dishes[0].description,
                                      style: const TextStyle(
                                        color: ColorPalette.lightBg,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10, left: 10),
                                        child: Text(
                                          '\$ ${MoneyFormatter(amount: state.menu[state.selectedCategory].dishes[0].price.toDouble()).output.withoutFractionDigits}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, bottom: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<OrderBloc>(context)
                                                .add(const AddOrderItem(0));
                                          },
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: ColorPalette.primary,
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                            child: const Icon(
                                              Remix.add_line,
                                              size: 20,
                                              color: ColorPalette.textColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
