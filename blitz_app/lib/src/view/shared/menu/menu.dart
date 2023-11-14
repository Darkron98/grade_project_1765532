import 'package:flutter/material.dart';
import 'package:grade_project_1765532/src/view/shared/menu/widgets/search_text_field.dart';

import '../../../style/style.dart';
import 'widgets/widgets.dart';

class Menu extends StatelessWidget {
  const Menu({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Tittle(),
        //const SizedBox(height: 10),
        CategorySlider(size: size),
        //const SizedBox(height: 20),
        SearchTextField(
          size: size,
          onChanged: (value) {},
          label: 'Buscar',
        ),
        const FoodCards(),
        const SizedBox(),
      ],
    );
  }
}

class Tittle extends StatelessWidget {
  const Tittle({
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
            'Menu',
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
