import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project_1765532/src/bloc/bloc.dart';

import '../../../style/style.dart';
import 'widgets/widgets.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const _Tittle(),
        BlocBuilder<MapBloc, MapState>(
          builder: (context, state) => OrderList(size: size),
        ),
      ],
    );
  }
}

class _Tittle extends StatelessWidget {
  const _Tittle();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 10,
            right: 10,
          ),
          child: Text(
            'Seguimiento',
            style: TextStyle(
              color: ColorPalette.textColor,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(),
      ],
    );
  }
}
