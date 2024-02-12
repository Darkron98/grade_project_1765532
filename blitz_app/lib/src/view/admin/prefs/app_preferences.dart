import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

import '../../../style/style.dart';

class AppPreferences extends StatelessWidget {
  const AppPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          const AdminTitle(),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Administración',
                style: TextStyle(
                  fontSize: 20,
                  color: ColorPalette.textColor,
                ),
              ),
              SizedBox(),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const AdminOptions(),
          const SizedBox(),
        ],
      ),
    );
  }
}

class AdminOptions extends StatefulWidget {
  const AdminOptions({super.key});

  @override
  State<AdminOptions> createState() => _AdminOptionsState();
}

class _AdminOptionsState extends State<AdminOptions> {
  late int selectIndex;

  @override
  void initState() {
    super.initState();
    selectIndex = 100;
  }

  void setIndex(int i) {
    selectIndex = i;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: selectIndex == 0 ? 155 : 60,
          decoration: BoxDecoration(
              color: ColorPalette.textColor,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ListTile(
                title: const Text(
                  'Menú',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                leading: const Icon(
                  Remix.restaurant_line,
                  size: 30,
                  color: ColorPalette.primary,
                ),
                trailing: Icon(
                  selectIndex == 0
                      ? Remix.arrow_drop_up_line
                      : Remix.arrow_drop_down_line,
                  size: 40,
                ),
                onTap: () => selectIndex != 0 ? setIndex(0) : setIndex(100),
              ),
              if (selectIndex == 0) ...[
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Remix.menu_add_fill,
                        size: 30,
                        color: ColorPalette.primary,
                      ),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: const Icon(
                        Remix.edit_box_line,
                        size: 30,
                        color: ColorPalette.primary,
                      ),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: const Icon(
                        Remix.delete_bin_7_line,
                        size: 30,
                        color: ColorPalette.primary,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
              const SizedBox(),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: selectIndex == 1 ? 155 : 60,
          decoration: BoxDecoration(
              color: ColorPalette.textColor,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ListTile(
                title: const Text(
                  'Personal',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                leading: const Icon(
                  Remix.user_follow_line,
                  size: 30,
                  color: ColorPalette.primary,
                ),
                trailing: Icon(
                  selectIndex == 1
                      ? Remix.arrow_drop_up_line
                      : Remix.arrow_drop_down_line,
                  size: 40,
                ),
                onTap: () => selectIndex != 1 ? setIndex(1) : setIndex(100),
              ),
              if (selectIndex == 1) ...[
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(
                      Remix.menu_add_fill,
                      size: 30,
                      color: ColorPalette.primary,
                    ),
                    Icon(
                      Remix.edit_box_line,
                      size: 30,
                      color: ColorPalette.primary,
                    ),
                    Icon(
                      Remix.delete_bin_7_line,
                      size: 30,
                      color: ColorPalette.primary,
                    ),
                  ],
                ),
              ],
              const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}

class AdminTitle extends StatelessWidget {
  const AdminTitle({
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
            right: 10,
          ),
          child: Text(
            'Preferencias',
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
