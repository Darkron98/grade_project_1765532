import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remixicon/remixicon.dart';

import '../../../bloc/menuPrefs/menu_prefs_bloc.dart';
import '../../../bloc/reg_employee/reg_employee_bloc.dart';
import '../../../style/style.dart';
import '../../shared/login/widget/widgets.dart';
import '../../widgets/snackbar.dart';

void registerEmployeeModal(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  var bloc = BlocProvider.of<RegEmployeeBloc>(context);
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => BlocProvider.value(
      value: bloc,
      child: BlocBuilder<RegEmployeeBloc, RegEmployeeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Container(
              decoration: BoxDecoration(
                  color: ColorPalette.background,
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: IntrinsicHeight(
                  child: Column(
                    //mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                                color: ColorPalette.lightBg,
                                borderRadius: BorderRadius.circular(2.5)),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Registrar Empleado',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorPalette.textColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            color: ColorPalette.darkBg,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 600,
                        child: PageView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            _Page1(size: size),
                            _Page2(size: size),
                          ],
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

class _Page1 extends StatelessWidget {
  const _Page1({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            const SizedBox(height: 15),
            CustomFormField(
                size: MediaQuery.of(context).size,
                onChanged: (value) => BlocProvider.of<RegEmployeeBloc>(context)
                    .add(TypeEmployeeName(value)),
                label: 'Nombre'),
            const SizedBox(height: 5),
            CustomFormField(
              size: size,
              onChanged: (value) => BlocProvider.of<RegEmployeeBloc>(context)
                  .add(TypeEmployeeLatName(value)),
              label: 'Apellidos',
            ),
            const SizedBox(height: 5),
            CustomFormField(
              size: MediaQuery.of(context).size,
              onChanged: (value) =>
                  BlocProvider.of<RegEmployeeBloc>(context).add(TypeDNI(value)),
              label: 'Documento de identidad',
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 5),
            CustomFormField(
              size: MediaQuery.of(context).size,
              onChanged: (value) => BlocProvider.of<RegEmployeeBloc>(context)
                  .add(TypeEmployeePhone(value)),
              label: 'Telefono',
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 5),
            CustomFormField(
              size: MediaQuery.of(context).size,
              onChanged: (value) => BlocProvider.of<RegEmployeeBloc>(context)
                  .add(
                      TypeSalary(value.isEmpty ? 0 : double.parse('$value.0'))),
              label: 'Salario',
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
          ],
        ),
        const Icon(
          Remix.arrow_right_s_line,
          size: 100,
          color: ColorPalette.lightBg,
        ),
      ],
    );
  }
}

class _Page2 extends StatelessWidget {
  const _Page2({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            const SizedBox(height: 15),
            CustomFormField(
                size: MediaQuery.of(context).size,
                onChanged: (value) => BlocProvider.of<RegEmployeeBloc>(context)
                    .add(TypeEmployeeMail(value)),
                label: 'E-mail'),
            const SizedBox(height: 5),
            CustomFormField(
              size: size,
              onChanged: (value) => BlocProvider.of<RegEmployeeBloc>(context)
                  .add(TypeEmployeeUser(value)),
              label: 'Usuario',
            ),
            const SizedBox(height: 5),
            CustomFormField(
                pass: true,
                size: MediaQuery.of(context).size,
                onChanged: (value) => BlocProvider.of<RegEmployeeBloc>(context)
                    .add(TypeEmployeePass(value)),
                label: 'Contraseña'),
            const SizedBox(height: 5),
            CustomFormField(
                pass: true,
                size: MediaQuery.of(context).size,
                onChanged: (value) => BlocProvider.of<RegEmployeeBloc>(context)
                    .add(TypeEmployeeConfirm(value)),
                label: 'Confirmar contraseña'),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(top: 27, bottom: 27),
          height: 100,
          child: BlocBuilder<RegEmployeeBloc, RegEmployeeState>(
            builder: (context, state) {
              return BlocListener<RegEmployeeBloc, RegEmployeeState>(
                listener: (context, state) {
                  if (state.success) {
                    Navigator.pop(context);
                    customSnackbar(context,
                        message: 'Empleado registrado!', type: 'ok');
                  } else if (state.success) {
                    customSnackbar(context,
                        message: 'Ups! algo salio mal', type: 'error');
                  }
                },
                child: CustomButton(
                    size: MediaQuery.of(context).size,
                    onPressed: state.loadingCreate
                        ? null
                        : () => BlocProvider.of<RegEmployeeBloc>(context)
                            .add(const InfoSubmmitt()),
                    color: ColorPalette.primary,
                    child: state.loadingCreate
                        ? const SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: ColorPalette.primary,
                            ),
                          )
                        : const Text('Registrar')),
              );
            },
          ),
        ),
      ],
    );
  }
}
