import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project_1765532/src/view/shared/menu/widgets/search_text_field.dart';

import '../../../bloc/bloc.dart';
import '../../../core/model/menu.dart';
import '../../../style/style.dart';
import 'widgets/widgets.dart';

class Menu extends StatelessWidget {
  Menu({
    super.key,
    required this.size,
  });

  final Size size;

  SwiperController controller = SwiperController();

  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state.menu.isEmpty && !state.loadingMenu) {
          BlocProvider.of<OrderBloc>(context).add(GetMenu());
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Tittle(),
            //const SizedBox(height: 10),
            if (state.menu.isNotEmpty) ...[
              CategorySlider(size: size),
              SearchTextField(
                controller: textController,
                size: size,
                onChanged: (value) =>
                    BlocProvider.of<OrderBloc>(context).add(SortWord(value)),
                label: 'Buscar',
                onPressed: () {
                  textController.clear();
                  BlocProvider.of<OrderBloc>(context).add(SortMenu(controller));
                },
              ),
            ],
            //const SizedBox(height: 20),
            state.loadingMenu
                ? const SizedBox(
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
                : state.menu.isEmpty
                    ? Container()
                    : FoodCards(controller: controller),
            const SizedBox(),
          ],
        );
      },
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
