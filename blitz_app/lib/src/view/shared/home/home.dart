import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project_1765532/src/core/logic/functions.dart';

import 'package:remixicon/remixicon.dart';

import '../../../bloc/bloc.dart';
import '../../../style/style.dart';
import '../../view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    PageController pageController = PageController();
    return Scaffold(
      extendBody: true,
      backgroundColor: ColorPalette.background,
      bottomNavigationBar: BottomNavBar(
        pageController: pageController,
        size: size,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          Navigator.of(context).pushReplacementNamed('login'),
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            color: ColorPalette.lightBg,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          Remix.logout_box_line,
                          color: ColorPalette.primary,
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: size.height - 180,
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Menu(size: size),
                    ShoppingCart(size: size),
                    MapScreen(size: size),
                    const Management(),
                  ],
                ),
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required PageController pageController,
    required this.size,
  }) : _pageController = pageController;

  final PageController _pageController;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          width: size.width,
          height: 70,
          decoration: const BoxDecoration(
            color: ColorPalette.lightBg,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavIcon(
                width: size.width,
                onTap: () {
                  BlocProvider.of<HomeBloc>(context).add(const ChangePage(0));
                  _pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                icon: Remix.apps_line,
                color: state.indexPage == 0
                    ? ColorPalette.primary
                    : ColorPalette.unFocused,
                size: state.indexPage == 0 ? 35 : null,
              ),
              NavIcon(
                width: size.width,
                onTap: () {
                  BlocProvider.of<HomeBloc>(context).add(const ChangePage(1));
                  _pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                icon: Remix.shopping_cart_line,
                color: state.indexPage == 1
                    ? ColorPalette.primary
                    : ColorPalette.unFocused,
                size: state.indexPage == 1 ? 35 : null,
              ),
              NavIcon(
                width: size.width,
                onTap: () {
                  BlocProvider.of<HomeBloc>(context).add(const ChangePage(2));
                  _pageController.animateToPage(
                    2,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                icon: Remix.road_map_line,
                color: state.indexPage == 2
                    ? ColorPalette.primary
                    : ColorPalette.unFocused,
                size: state.indexPage == 2 ? 35 : null,
              ),
              NavIcon(
                width: size.width,
                onTap: () {
                  BlocProvider.of<HomeBloc>(context).add(const ChangePage(3));
                  _pageController.animateToPage(
                    3,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                icon: Remix.user_line,
                color: state.indexPage == 3
                    ? ColorPalette.primary
                    : ColorPalette.unFocused,
                size: state.indexPage == 3 ? 35 : null,
              ),
            ],
          ),
        );
      },
    );
  }
}

class NavIcon extends StatelessWidget {
  const NavIcon({
    super.key,
    required this.icon,
    this.onTap,
    required this.color,
    this.size,
    required this.width,
  });

  final IconData icon;
  final Function()? onTap;
  final Color color;
  final double? size;
  final double width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width * 0.25,
        height: 70,
        child: Icon(
          icon,
          color: color,
          size: size ?? 30,
        ),
      ),
    );
  }
}