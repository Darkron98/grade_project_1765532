import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project_1765532/src/view/shared/menu/widgets/search_text_field.dart';
import 'package:remixicon/remixicon.dart';

import '../../../bloc/reg_employee/reg_employee_bloc.dart';
import '../../../style/style.dart';
import '../../shared/login/widget/widgets.dart';
import '../../widgets/snackbar.dart';

void updateEmployeeModal(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  var bloc = BlocProvider.of<RegEmployeeBloc>(context);
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => ModalContent(bloc: bloc, size: size),
  );
}

class ModalContent extends StatelessWidget {
  ModalContent({
    super.key,
    required this.bloc,
    required this.size,
  });

  final RegEmployeeBloc bloc;
  final Size size;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<RegEmployeeBloc, RegEmployeeState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Container(
                decoration: BoxDecoration(
                    color: ColorPalette.background,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: IntrinsicHeight(
                    child: BlocBuilder<RegEmployeeBloc, RegEmployeeState>(
                      builder: (context, state) {
                        return Column(
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
                                  'Actualizar Datos\nde empleado',
                                  textAlign: TextAlign.center,
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
                            const SizedBox(height: 20),
                            SearchTextField(
                              controller: controller,
                              size: size,
                              onChanged: (value) =>
                                  BlocProvider.of<RegEmployeeBloc>(context)
                                      .add(TypeDNI(value)),
                              label: 'Buscar por ID',
                              onPressed: () =>
                                  BlocProvider.of<RegEmployeeBloc>(context)
                                      .add(const GetEmployee()),
                            ),
                            if (state.loadingCreate) ...[
                              const SizedBox(height: 20),
                              const SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: ColorPalette.primary,
                                ),
                              ),
                            ],
                            const SizedBox(height: 20),
                            if (state.employee.isNotEmpty) ...[
                              const EmployeeListTile()
                            ],
                            SizedBox(
                                height:
                                    MediaQuery.of(context).viewInsets.bottom +
                                        10),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class EmployeeListTile extends StatefulWidget {
  const EmployeeListTile({
    super.key,
  });

  @override
  State<EmployeeListTile> createState() => _EmployeeListTileState();
}

class _EmployeeListTileState extends State<EmployeeListTile> {
  late bool selected;

  @override
  initState() {
    super.initState();
    selected = false;
  }

  void isSelect() {
    setState(() {});
    selected = !selected;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<RegEmployeeBloc, RegEmployeeState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: ColorPalette.lightBg,
                    borderRadius: BorderRadius.circular(10)),
                height: 60,
                child: ListTile(
                  leading: const Icon(
                    Remix.user_line,
                    color: ColorPalette.primary,
                    size: 30,
                  ),
                  title: Text(
                    '${state.employee[0].name} ${state.employee[0].lastName}',
                    style: const TextStyle(
                      color: ColorPalette.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: isSelect,
                    child: Icon(
                      selected ? Remix.edit_box_fill : Remix.edit_box_line,
                      color: ColorPalette.primary,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            if (selected) ...[
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorPalette.lightBg,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: ColorPalette.lightBg,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 45),
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    color: ColorPalette.unFocused,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () => customAlert(context),
                                      child: const Icon(
                                        Remix.user_unfollow_line,
                                        color: ColorPalette.lightBg,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            CustomFormField(
                              onChanged: (value) =>
                                  BlocProvider.of<RegEmployeeBloc>(context)
                                      .add(TypeEmployeeName(value)),
                              size: size,
                              label: 'Nombre',
                            ),
                            CustomFormField(
                              onChanged: (value) =>
                                  BlocProvider.of<RegEmployeeBloc>(context)
                                      .add(TypeEmployeeLatName(value)),
                              size: size,
                              label: 'Apellidos',
                            ),
                            CustomFormField(
                                onChanged: (value) =>
                                    BlocProvider.of<RegEmployeeBloc>(context)
                                        .add(TypeDNI(value)),
                                size: size,
                                label: 'Documento de identidad',
                                formatter: [
                                  FilteringTextInputFormatter.digitsOnly
                                ]),
                            CustomFormField(
                                onChanged: (value) =>
                                    BlocProvider.of<RegEmployeeBloc>(context)
                                        .add(TypeEmployeePhone(value)),
                                size: size,
                                label: 'Telefono',
                                formatter: [
                                  FilteringTextInputFormatter.digitsOnly
                                ]),
                            CustomFormField(
                              onChanged: (value) =>
                                  BlocProvider.of<RegEmployeeBloc>(context)
                                      .add(TypeEmployeeMail(value)),
                              size: size,
                              label: 'E-Mail',
                            ),
                            CustomFormField(
                                onChanged: (value) =>
                                    BlocProvider.of<RegEmployeeBloc>(context)
                                        .add(TypeSalary(value.isEmpty
                                            ? 0
                                            : double.parse(value))),
                                size: size,
                                label: 'Salario',
                                formatter: [
                                  FilteringTextInputFormatter.digitsOnly
                                ]),
                            BlocBuilder<RegEmployeeBloc, RegEmployeeState>(
                              builder: (context, state) {
                                return BlocListener<RegEmployeeBloc,
                                    RegEmployeeState>(
                                  listener: (context, state) {
                                    if (state.success) {
                                      Navigator.pop(context);
                                      customSnackbar(context,
                                          message: 'Datos Actualizados',
                                          type: 'ok');
                                    } else if (state.failure ||
                                        state.delFailure) {
                                      Navigator.pop(context);
                                      customSnackbar(context,
                                          message: 'Ups! algo salio mal',
                                          type: 'error');
                                    } else if (state.delSuccess) {
                                      Navigator.pop(context);
                                      customSnackbar(context,
                                          message: 'Empleado despedido :c',
                                          type: 'ok');
                                    }
                                  },
                                  child: CustomButton(
                                      size: MediaQuery.of(context).size,
                                      onPressed: state.loadingCreate ||
                                              state.loadingUpdate ||
                                              state.loadingDelete
                                          ? null
                                          : () =>
                                              BlocProvider.of<RegEmployeeBloc>(
                                                      context)
                                                  .add(const UpdateEmployee()),
                                      color: ColorPalette.primary,
                                      child: state.loadingUpdate ||
                                              state.loadingDelete
                                          ? const SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: CircularProgressIndicator(
                                                color: ColorPalette.primary,
                                              ),
                                            )
                                          : const Text('Actualizar')),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

Future<dynamic> customAlert(BuildContext context) {
  var bloc = BlocProvider.of<RegEmployeeBloc>(context);
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocProvider.value(
        value: bloc,
        child: BlocBuilder<RegEmployeeBloc, RegEmployeeState>(
          builder: (context, state) {
            return BlocListener<RegEmployeeBloc, RegEmployeeState>(
              listener: (context, state) {
                if (state.delSuccess) {
                  Navigator.pop(context);
                }
              },
              child: AlertDialog(
                title:
                    Text(state.loadingDelete ? 'Procesando' : 'Estas seguro?'),
                content: state.loadingDelete
                    ? SizedBox(
                        width: 40,
                        height: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            SizedBox(),
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: ColorPalette.primary,
                              ),
                            ),
                            SizedBox(),
                          ],
                        ),
                      )
                    : const Text('Deseas despedir a este empleado?'),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor:
                            const Color.fromARGB(255, 86, 50, 136)),
                    onPressed: state.loadingDelete
                        ? null
                        : () {
                            BlocProvider.of<RegEmployeeBloc>(context)
                                .add(const FireEmployee());
                          },
                    child: const Text('Aceptar'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: ColorPalette.primary),
                    onPressed: state.loadingDelete
                        ? null
                        : () {
                            Navigator.of(context).pop();
                          },
                    child: const Text('Cerrar'),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
