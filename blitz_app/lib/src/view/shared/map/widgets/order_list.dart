// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../bloc/bloc.dart';
import '../../../../core/logic/functions.dart';
import '../../../../style/style.dart';
import 'widgets.dart';

class OrderList extends StatelessWidget {
  const OrderList({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            height: size.height * 0.6,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                separatorBuilder: (context, i) => const SizedBox(height: 15),
                itemBuilder: (context, i) => Container(
                  decoration: BoxDecoration(
                      color: ColorPalette.lightBg,
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: const Padding(
                      padding: EdgeInsets.only(top: 9),
                      child: Icon(
                        Remix.radio_button_line,
                        color: ColorPalette.unFocused,
                      ),
                    ),
                    title: const Text(
                      'Numero',
                      style: TextStyle(
                        color: ColorPalette.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      'cliente',
                      style: TextStyle(
                        color: ColorPalette.textColor,
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: ColorPalette.primary,
                          borderRadius: BorderRadius.circular(7)),
                      child: GestureDetector(
                        onTap: () async {
                          if (state.srcLat == 0 && state.srcLng == 0) {
                            double lat = await getLocationLat();
                            double long = await getLocationLong();
                            BlocProvider.of<MapBloc>(context)
                                .add(SetSrcLocation(lat, long));
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NavigationWidget()));
                        },
                        child: const Icon(
                          Remix.guide_fill,
                          color: ColorPalette.textColor,
                          size: 25,
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
