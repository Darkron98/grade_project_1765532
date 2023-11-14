import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

import '../../../style/style.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CartTitle(),
        //const SizedBox(height: 20),
        const CartItemList(),
        //const SizedBox(height: 20),
        const InstructionsPanel(),
        //const SizedBox(height: 30),
        CheckInButton(
          size: size,
          onPressed: () {},
        ),
        SizedBox(),
      ],
    );
  }
}

class CheckInButton extends StatelessWidget {
  const CheckInButton({super.key, required this.size, required this.onPressed});
  final Size size;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.175, right: size.width * 0.175, bottom: 0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromHeight(45),
            backgroundColor: ColorPalette.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: onPressed,
          child: const Text(
            'Terminar',
            style: TextStyle(color: ColorPalette.textColor),
          ),
        ),
      ),
    );
  }
}

class InstructionsPanel extends StatelessWidget {
  const InstructionsPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: ColorPalette.darkBg,
            borderRadius: BorderRadius.circular(10)),
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            cursorColor: ColorPalette.textColor,
            style: TextStyle(color: ColorPalette.textColor),
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Comentarios',
              hintStyle: TextStyle(color: ColorPalette.unFocused),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

class CartItemList extends StatelessWidget {
  const CartItemList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 225,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 15, right: 15),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, i) => ListTile(
          title: const Text(
            'Fries',
            style: TextStyle(
              color: ColorPalette.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text(
            '\$5',
            style: TextStyle(
              color: ColorPalette.textColor,
            ),
          ),
          trailing: Container(
            width: 150,
            height: 50,
            decoration: BoxDecoration(
                color: ColorPalette.darkBg,
                borderRadius: BorderRadius.circular(15)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(
                    Remix.subtract_fill,
                    color: ColorPalette.cartIcons,
                  ),
                  Text(
                    '1',
                    style: TextStyle(
                      color: ColorPalette.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Icon(
                    Remix.add_fill,
                    color: ColorPalette.cartIcons,
                  ),
                ]),
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const Image(
              width: 50,
              image: NetworkImage(
                  'https://thissillygirlskitchen.com/wp-content/uploads/2020/02/homemade-french-fries-8-1-500x500.jpg'),
            ),
          ),
        ),
        itemCount: 3,
      ),
    );
  }
}

class CartTitle extends StatelessWidget {
  const CartTitle({
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
            'Carrito',
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
