import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../style/style.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      decoration: BoxDecoration(
          color: ColorPalette.lightBg, borderRadius: BorderRadius.circular(20)),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        separatorBuilder: (context, i) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            color: ColorPalette.background,
          ),
        ),
        itemBuilder: (context, i) => ListTile(
          leading: const CircleAvatar(
            backgroundColor: ColorPalette.primary,
          ),
          title: const Text(
            'Nombre',
            style: TextStyle(
              color: ColorPalette.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text(
            'cargo',
            style: TextStyle(
              color: ColorPalette.textColor,
            ),
          ),
          trailing: GestureDetector(
            onTap: () => idCardModal(context, size),
            child: const Icon(
              Remix.more_2_fill,
              color: ColorPalette.unFocused,
            ),
          ),
        ),
      ),
    );
  }
}

void idCardModal(BuildContext context, Size size) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.2,
          right: size.width * 0.2,
          bottom: size.height * 0.25),
      child: Container(
        height: 370,
        decoration: BoxDecoration(
            color: ColorPalette.textColor,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(), //to do: logo empresa
            const CircleAvatar(
              backgroundColor: ColorPalette.greyText,
              radius: 35,
            ),
            Column(
              children: const [
                Text(
                  'Nombre',
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(),
                ),
                Text(
                  'id',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            const Text(
              'cargo',
              style: TextStyle(fontSize: 16),
            ),
            Column(
              children: const [
                Text(
                  'Telefono',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Correo',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Column(
              children: [
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(Remix.delete_bin_fill),
                      Icon(Remix.edit_fill),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
