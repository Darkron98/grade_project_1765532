// ignore_for_file: no_logic_in_create_state, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

import '../../../style/style.dart';
import 'widget/widgets.dart';

class Management extends StatelessWidget {
  const Management({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const ManagementTitle(),
        SearchEmployee(
          size: size,
          label: 'Buscar',
          onChanged: (value) {},
        ),
        EmployeeList(size: size),
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: RegEmpLabel(),
        ),
      ],
    );
  }
}

class RegEmpLabel extends StatelessWidget {
  const RegEmpLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Registrar ',
          style: TextStyle(color: ColorPalette.textColor),
        ),
        GestureDetector(
          onTap: () {
            //BlocProvider.of<AuthBloc>(context).add(const GoRegister(1));
          },
          child: const Text(
            'nuevo empleado',
            style: TextStyle(
              color: ColorPalette.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class ManagementTitle extends StatelessWidget {
  const ManagementTitle({
    super.key,
  });

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
            'Gestion de personal',
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
