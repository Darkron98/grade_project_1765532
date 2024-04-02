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
/*   IconData icon =
      type == 'ok' ? Remix.shield_check_fill : Remix.error_warning_fill; */

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        dismissDirection: DismissDirection.startToEnd,
        elevation: 0,
        content: SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [color, iconColor])),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              message,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (subtittle != null) ...[
                              Text(
                                subtittle,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ]
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: SizedBox(
                          child: Icon(
                            Remix.close_fill,
                            color: color,
                            size: 30,
                          ),
                        ),
                        onTap: () =>
                            ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
}
