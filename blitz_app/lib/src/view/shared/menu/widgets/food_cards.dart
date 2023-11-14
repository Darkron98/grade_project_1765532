import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../style/style.dart';

class FoodCards extends StatelessWidget {
  const FoodCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: SizedBox(
        height: 260,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            alignment: Alignment.topLeft,
            child: Swiper(
              layout: SwiperLayout.CUSTOM,
              customLayoutOption:
                  CustomLayoutOption(startIndex: -1, stateCount: 4)
                    ..addTranslate([
                      const Offset(-350.0, 0.0),
                      const Offset(-60, 0.0),
                      const Offset(165, 0.0),
                      const Offset(350, 0.0),
                    ])
                    ..addScale([0.7, 1, 0.75, 0.7], Alignment.topRight)
                    ..addOpacity([0.1, 1, 0.4, 0.1]),
              itemWidth: 210,
              itemHeight: 260,
              fade: 0.01,
              physics: const BouncingScrollPhysics(),
              loop: false,
              viewportFraction: 0.4,
              scale: 0.5,
              itemCount: 20,
              itemBuilder: (BuildContext context, int i) => Container(
                width: 210,
                height: 260,
                decoration: BoxDecoration(
                    color: ColorPalette.textColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 10, right: 10, bottom: 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7.5),
                          child: const Image(
                            width: 210,
                            image: NetworkImage(
                              'https://comidasamericanas.net/wp-content/uploads/2021/10/Hamburguesas-americanas-1.jpg',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 0),
                      child: Text(
                        'Cangreburger',
                        style: TextStyle(
                          color: ColorPalette.lightBg,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 0),
                      child: Text(
                        'Desc',
                        style: TextStyle(
                          color: ColorPalette.lightBg,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10, left: 10),
                          child: Text(
                            '\$18',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, bottom: 10),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: ColorPalette.primary,
                                  borderRadius: BorderRadius.circular(7)),
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
            ),
          ),
        ),
      ),
    );
  }
}
