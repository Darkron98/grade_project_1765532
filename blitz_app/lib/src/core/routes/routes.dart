import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import '../../bloc/menuPrefs/menu_prefs_bloc.dart';
import '../../bloc/reg_employee/reg_employee_bloc.dart';
import '../../view/view.dart';

Map<String, WidgetBuilder> navigation() => <String, WidgetBuilder>{
      'login': (context) => Login(),
      'home': (context) => MultiBlocProvider(providers: [
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
            BlocProvider(
              create: (context) => OrderBloc(),
            ),
          ], child: const HomeScreen()),
    };
