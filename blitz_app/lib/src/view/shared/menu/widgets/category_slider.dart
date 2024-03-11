import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/bloc.dart';
import '../../../../style/style.dart';

class CategorySlider extends StatelessWidget {
  const CategorySlider({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(),
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: ClipRRect(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: state.menu.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.only(left: 10, right: 0),
                  child: GestureDetector(
                    onTap: () => BlocProvider.of<OrderBloc>(context)
                        .add(SelectCategory(i)),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: state.selectedCategory == i
                              ? ColorPalette.primary
                              : ColorPalette.lightBg,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          state.menu[i].categoryName,
                          style: TextStyle(
                              color: state.selectedCategory == i
                                  ? ColorPalette.textColor
                                  : ColorPalette.unFocused,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
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
