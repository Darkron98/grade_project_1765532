import 'package:flutter/material.dart';

import '../../../../style/style.dart';

class ItemField extends StatelessWidget {
  const ItemField({
    super.key,
    this.icon,
    this.name,
    this.value,
    this.textColor,
    this.iconColor,
  });

  final IconData? icon;
  final String? name;
  final String? value;
  final Color? textColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 4, bottom: 4),
        width: double.infinity,
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 160,
                  child: Text(
                    name ?? 'Name',
                    style: TextStyle(
                      color: textColor ?? ColorPalette.textColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(),
              ],
            ),
            Text(
              value ?? 'value',
              style: TextStyle(
                color: textColor ?? ColorPalette.textColor,
                fontSize: 14,
              ),
            ),
            const SizedBox()
          ],
        ),
      ),
    );
  }
}
