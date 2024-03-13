import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project_1765532/src/core/logic/shared_preferences.dart';

import '../../../../bloc/bloc.dart';
import '../../../../style/color/palette.dart';

class RemainUser extends StatefulWidget {
  const RemainUser({
    super.key,
  });

  @override
  State<RemainUser> createState() => _RemainUserState();
}

class _RemainUserState extends State<RemainUser> {
  bool remain = Preferences().remain;
  void changeCheckBox() {
    setState(() {
      remain = !remain;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Recordar usuario',
                style: TextStyle(color: ColorPalette.textColor),
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return Checkbox(
                    splashRadius: 0,
                    value: state.remain,
                    onChanged: state.loading
                        ? null
                        : (value) => BlocProvider.of<AuthBloc>(context)
                            .add(RemainOption(value ?? false)),
                    fillColor: MaterialStateProperty.all(state.loading
                        ? ColorPalette.unFocused
                        : ColorPalette.primary),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
