import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project_1765532/src/core/logic/shared_preferences.dart';
import 'package:grade_project_1765532/src/view/admin/app_preferences.dart';
import 'package:grade_project_1765532/src/view/widgets/snackbar.dart';

import 'package:remixicon/remixicon.dart';

import '../../../bloc/bloc.dart';

import '../../../style/style.dart';
import '../../view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool newOrder;

  void newOrderFlag(bool flag) {
    newOrder = flag;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    newOrder = false;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        newOrder = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (newOrder && !BlocProvider.of<OrderBloc>(context).state.loadingOrders) {
      BlocProvider.of<HomeBloc>(context).add(const NewOrder(true));
      BlocProvider.of<OrderBloc>(context).add(GetOrderList());
      BlocProvider.of<HomeBloc>(context).add(const NewOrder(false));
      newOrderFlag(false);
    }
    PageController pageController = PageController();
    return Scaffold(
      extendBody: true,
      backgroundColor: ColorPalette.background,
      bottomNavigationBar: BottomNavBar(
        pageController: pageController,
        size: size,
      ),
      body: SafeArea(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
              systemNavigationBarColor: ColorPalette.background,
              systemNavigationBarIconBrightness: Brightness.dark,
              systemNavigationBarDividerColor: Colors.transparent),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state.newOrder) {
                  customSnackbar(context,
                      message: 'Se han actualizado los pedidos', type: 'ok');
                  BlocProvider.of<HomeBloc>(context).add(const ChangePage(2));
                  pageController.animateToPage(
                    2,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<HomeBloc>(context)
                                .add(const ChangePage(0));
                            pageController.animateToPage(
                              0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                            Navigator.of(context).pushReplacementNamed('login');
                          },
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
                        //const Management(),
                        const AppPreferences(),
                      ],
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
            ),
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
              if (Preferences().rol == 1) ...[
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
                  icon: Remix.user_settings_line,
                  color: state.indexPage == 3
                      ? ColorPalette.primary
                      : ColorPalette.unFocused,
                  size: state.indexPage == 3 ? 35 : null,
                ),
              ],
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
