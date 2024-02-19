import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project_1765532/src/bloc/register/register_bloc.dart';
import 'package:grade_project_1765532/src/view/shared/menu/widgets/search_text_field.dart';
import 'package:remixicon/remixicon.dart';

import '../../../bloc/reg_employee/reg_employee_bloc.dart';
import '../../../style/style.dart';
import '../../shared/login/widget/widgets.dart';

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
  const ModalContent({
    super.key,
    required this.bloc,
    required this.size,
  });

  final RegEmployeeBloc bloc;
  final Size size;

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
                            CustomButton(
                                size: MediaQuery.of(context).size,
                                onPressed: state.loadingCreate ||
                                        state.loadingUpdate
                                    ? null
                                    : () => BlocProvider.of<RegEmployeeBloc>(
                                            context)
                                        .add(const InfoSubmmitt()),
                                color: ColorPalette.primary,
                                child: state.loadingUpdate
                                    ? const SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                          color: ColorPalette.primary,
                                        ),
                                      )
                                    : const Text('Actualizar')),
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
