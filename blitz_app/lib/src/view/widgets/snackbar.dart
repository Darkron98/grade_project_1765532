import 'package:flutter/material.dart';
import 'package:grade_project_1765532/src/style/color/palette.dart';
import 'package:remixicon/remixicon.dart';

void customSnackbar(
  BuildContext context, {
  required String message,
  required String type,
  String? subtittle,
  bool? success,
}) {
  Color color = type == 'ok'
      ? const Color.fromARGB(255, 39, 190, 129)
      : ColorPalette.primary;
  Color iconColor = type == 'ok'
      ? const Color.fromARGB(255, 0, 255, 153)
      : const Color.fromARGB(255, 236, 101, 101);
  IconData icon =
      type == 'ok' ? Remix.shield_check_fill : Remix.error_warning_fill;

  ScaffoldMessenger.of(context)
    ..hideCurrentMaterialBanner()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        dismissDirection: DismissDirection.startToEnd,
        elevation: 0,
        content: SizedBox(
          height: 100,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                height: 75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [color, iconColor])),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            message,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (subtittle != null) ...[
                            Text(
                              subtittle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ]
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 7,
                top: 12,
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 50,
                ),
              ),
              /* Positioned(
                right: 5,
                top: 27,
                child: GestureDetector(
                  child: const SizedBox(
                    child: Icon(
                      Remix.close_fill,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  onTap: () =>
                      ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                ),
              ), */
            ],
          ),
        ),
      ),
    );
}
