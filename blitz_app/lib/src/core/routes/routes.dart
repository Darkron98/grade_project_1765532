import 'package:flutter/widgets.dart';

import '../../view/view.dart';

Map<String, WidgetBuilder> navigation() => <String, WidgetBuilder>{
      'login': (context) => Login(),
      'home': (context) => const HomeScreen(),
    };
