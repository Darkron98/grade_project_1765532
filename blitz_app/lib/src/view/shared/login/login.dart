// ignore_for_file: use_build_context_synchronously

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project_1765532/src/bloc/bloc.dart';
import 'package:grade_project_1765532/src/core/logic/shared_preferences.dart';
import 'package:grade_project_1765532/src/view/shared/register/register.dart';
import 'package:grade_project_1765532/src/view/widgets/snackbar.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:permission_handler/permission_handler.dart';

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
    if (!Preferences().requestNotiPerm) {
      getNotiPermission(context);
    }
    //getLocationPermission();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          systemNavigationBarColor: ColorPalette.background,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: Colors.transparent),
      child: Scaffold(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const _Tittle(),
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        Column(
                          children: [
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return CustomFormField(
                                  controller: state.remain
                                      ? TextEditingController(
                                          text: Preferences().user)
                                      : null,
                                  size: size,
                                  label: 'Usuario / Telefono',
                                  onChanged: (value) =>
                                      BlocProvider.of<AuthBloc>(context)
                                          .add(TypeUser(value)),
                                );
                              },
                            ),
                            CustomFormField(
                              size: size,
                              pass: true,
                              label: 'Contraseña',
                              onChanged: (value) =>
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(TypePass(value)),
                            ),
                            const RemainUser(),
                            BlocListener<AuthBloc, AuthState>(
                              listener: (context, state) {
                                if (state.success) {
                                  customSnackbar(
                                    context,
                                    message: 'Bienvenido!',
                                    type: 'ok',
                                  );
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
                                        validateLogin(
                                            state.userName, state.pass)
                                    ? ColorPalette.unFocused
                                    : ColorPalette.primary,
                                onPressed: state.loading ||
                                        validateLogin(
                                            state.userName, state.pass)
                                    ? null
                                    : () async {
                                        if (await Permission
                                            .location.isGranted) {
                                          BlocProvider.of<AuthBloc>(context)
                                              .add(const Submitted());
                                        } else if (await Permission
                                            .location.isPermanentlyDenied) {
                                          locationAlert(context);
                                        } else {
                                          var locationStatus =
                                              await getLocationPermission();
                                          if (locationStatus.isGranted) {
                                            BlocProvider.of<AuthBloc>(context)
                                                .add(const Submitted());
                                          }
                                        }
                                      },
                                child: state.loading
                                    ? const SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                          color: ColorPalette.primary,
                                        ),
                                      )
                                    : Text(
                                        'Ingresar',
                                        style: TextStyle(
                                            color: validateLogin(
                                                    state.userName, state.pass)
                                                ? ColorPalette.unFocused
                                                : ColorPalette.textColor),
                                      ),
                              ),
                            ),
                            RegisterLabel(
                              pageController: _pageController,
                            ),
                          ],
                        ),
                        const SizedBox(),
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

Future<dynamic> locationAlert(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: ColorPalette.background,
        title: const Text(
          'Error!',
          style: TextStyle(color: ColorPalette.textColor),
        ),
        content: const Text(
          'Necesita otorgar permisos de localizacion',
          style: TextStyle(color: ColorPalette.textColor),
        ),
        actions: [
          TextButton(
            style:
                TextButton.styleFrom(foregroundColor: ColorPalette.unFocused),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cerrar'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: ColorPalette.primary),
            onPressed: () {
              AppSettings.openAppSettings();
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, 'login');
            },
            child: const Text('Ir a ajustes'),
          ),
        ],
      );
    },
  );
}

Future<dynamic> notificationAlert(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: ColorPalette.background,
        content: const Text(
          'Blitz solicita permisos para mostrar notificaciones (opcional).',
          textAlign: TextAlign.justify,
          style: TextStyle(color: ColorPalette.textColor),
        ),
        actions: [
          TextButton(
            style:
                TextButton.styleFrom(foregroundColor: ColorPalette.unFocused),
            onPressed: () {
              Preferences().requestNotiPerm = true;
              Navigator.of(context).pop();
            },
            child: const Text('No preguntar denuevo'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: ColorPalette.primary),
            onPressed: () async {
              var permission = await NotificationPermissions
                  .requestNotificationPermissions();
              Preferences().requestNotiPerm = true;
              Navigator.of(context).pop();
            },
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
}
