import 'package:flutter/material.dart';

import '../../../../style/style.dart';

class CategorySlider extends StatelessWidget {
  const CategorySlider({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: ClipRRect(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, i) => Padding(
              padding: EdgeInsets.only(left: 10, right: i == 4 ? 10 : 0),
              child: Container(
                width: size.width * 0.3,
                height: 35,
                decoration: BoxDecoration(
                    color: ColorPalette.lightBg,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
