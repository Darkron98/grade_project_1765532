import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project_1765532/src/bloc/bloc.dart';
import 'package:grade_project_1765532/src/core/logic/shared_preferences.dart';
import 'package:grade_project_1765532/src/view/shared/register/register.dart';
import 'package:grade_project_1765532/src/view/widgets/snackbar.dart';

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
                          CustomFormField(
                            size: size,
                            label: 'Usuario',
                            onChanged: (value) =>
                                BlocProvider.of<AuthBloc>(context)
                                    .add(TypeUser(value)),
                          ),
                          CustomFormField(
                            size: size,
                            pass: true,
                            label: 'Contraseña',
                            onChanged: (value) =>
                                BlocProvider.of<AuthBloc>(context)
                                    .add(TypePass(value)),
                          ),
                          BlocListener<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state.success) {
                                customSnackbar(context,
                                    message: 'Bienvenido!',
                                    type: 'ok',
                                    subtittle: Preferences().user);
                                Navigator.pushNamed(context, 'home');
                              } else if (state.failure) {
                                customSnackbar(
                                  context,
                                  message: 'Ups! algo salio mal',
                                  type: 'error',
                                );
                              }
                            },
                            child: CustomButton(
                              size: size,
                              color: state.loading ||
                                      validateLogin(state.userName, state.pass)
                                  ? ColorPalette.unFocused
                                  : ColorPalette.primary,
                              onPressed: state.loading ||
                                      validateLogin(state.userName, state.pass)
                                  ? null
                                  : () {
                                      BlocProvider.of<AuthBloc>(context)
                                          .add(const Submitted());
                                    },
                              child: state.loading
                                  ? const SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        color: ColorPalette.primary,
                                      ),
                                    )
                                  : const Text(
                                      'Ingresar',
                                      style: TextStyle(
                                          color: ColorPalette.textColor),
                                    ),
                            ),
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
  const _Tittle();

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
