import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project_1765532/src/bloc/menuPrefs/menu_prefs_bloc.dart';

import 'bloc/bloc.dart';
import 'bloc/reg_employee/reg_employee_bloc.dart';
import 'core/routes/routes.dart';
import 'style/style.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => MapBloc(),
        ),
        BlocProvider(
          create: (context) => MenuPrefsBloc(),
        ),
        BlocProvider(
          create: (context) => RegEmployeeBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blitz',
        routes: navigation(),
        initialRoute: 'login',
        theme: ThemeData(
          primaryColor: ColorPalette.primary,
          textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: ColorPalette.primary,
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                surfaceTintColor:
                    MaterialStateProperty.all(Colors.transparent)),
          ),
        ),
      ),
    );
  }
}
