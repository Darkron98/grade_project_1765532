import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/bloc.dart';
import '../../../../style/style.dart';

class FoodLoadingCards extends StatelessWidget {
  const FoodLoadingCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 0),
          child: SizedBox(
            height: 260,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                alignment: Alignment.topLeft,
                child: BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    return Swiper(
                      layout: SwiperLayout.CUSTOM,
                      customLayoutOption: CustomLayoutOption(
                          startIndex: state.startIndex, stateCount: 2)
                        ..addTranslate([
                          const Offset(-60, 0.0),
                          const Offset(165, 0.0),
                        ])
                        ..addScale([1, 0.75], Alignment.topRight)
                        ..addOpacity([1, 1]),
                      itemWidth: 210,
                      itemHeight: 260,
                      fade: 0.01,
                      physics: const NeverScrollableScrollPhysics(),
                      loop: false,
                      viewportFraction: 0.4,
                      scale: 0.5,
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int i) => Container(
                        width: 210,
                        height: 260,
                        decoration: BoxDecoration(
                            color: ColorPalette.lightBg,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
