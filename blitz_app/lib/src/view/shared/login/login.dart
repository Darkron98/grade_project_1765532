import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project_1765532/src/bloc/bloc.dart';
import 'package:grade_project_1765532/src/view/shared/register/register.dart';

import '../../../core/logic/functions.dart';
import '../../../style/style.dart';
import 'widget/widgets.dart';

class Login extends StatelessWidget {
  Login({
    super.key,
  });
  final PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var bloc = BlocProvider.of<AuthBloc>(context);
    getLocationPermission();
    return Scaffold(
      backgroundColor: ColorPalette.background,
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) => PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Center(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const _Tittle(),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Column(
                        children: [
                          LoginFormField(
                            size: size,
                            label: 'Usuario',
                            onChanged: (value) =>
                                BlocProvider.of<AuthBloc>(context)
                                    .add(TypeUser(value)),
                          ),
                          LoginFormField(
                            size: size,
                            pass: true,
                            label: 'Contraseña',
                            onChanged: (value) =>
                                BlocProvider.of<AuthBloc>(context)
                                    .add(TypePass(value)),
                          ),
                          const RemainUser(),
                          LoginButton(
                            size: size,
                            onPressed: () {
                              BlocProvider.of<HomeBloc>(context)
                                  .add(const ChangePage(0));
                              Navigator.pushNamed(context, 'home');
                            },
                          ),
                          RegisterLabel(
                            pageController: _pageController,
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.04),
                      /* const Image(
                          image: AssetImage('assets/univalle.png'),
                          width: 50,
                          color: ColorPalette.primery,
                        ), */
                    ],
                  ),
                ),
              ),
              Register(
                size: size,
                pageController: _pageController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tittle extends StatelessWidget {
  const _Tittle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Image(
            image: AssetImage('assets/ez_logo.png'),
            width: 70,
            color: ColorPalette.primary,
          ),
          Text(
            'Blit',
            style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: ColorPalette.textColor),
          ),
          SizedBox(width: 2.5),
          Text(
            'Z',
            style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: ColorPalette.primary),
          )
        ],
      ),
    );
  }
}
