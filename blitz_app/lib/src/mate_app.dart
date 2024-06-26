import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';
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
          create: (context) => MapBloc(),
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
