import 'package:flutter/material.dart';

import '../../../../style/color/palette.dart';

class RemainUser extends StatelessWidget {
  const RemainUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Recordar usuario',
            style: TextStyle(color: ColorPalette.textColor),
          ),
          Checkbox(
            splashRadius: 0,
            value: true,
            onChanged: (value) {},
            fillColor: MaterialStateProperty.all(ColorPalette.primary),
          )
        ],
      ),
    );
  }
}
