import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project_1765532/src/style/style.dart';
import 'package:grade_project_1765532/src/view/widgets/snackbar.dart';
import 'package:remixicon/remixicon.dart';

import '../../../bloc/bloc.dart';
import '../login/widget/widgets.dart';

class Register extends StatelessWidget {
  const Register({super.key, required this.size, required this.pageController});
  final Size size;
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) => Center(
        child: SizedBox(
          width: double.infinity,
          height: size.height,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: size.height - 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BackButton(size: size, pageController: pageController),
                  Tittle(size: size),
                  Column(
                    children: [
                      CustomFormField(
                        size: size,
                        onChanged: (value) =>
                            BlocProvider.of<RegisterBloc>(context)
                                .add(TypeName(value)),
                        label: 'Nombre',
                        helper: 'Minimo 3 caracteres (solo letras)',
                        formatter: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z]+')),
                        ],
                      ),
                      CustomFormField(
                        size: size,
                        onChanged: (value) =>
                            BlocProvider.of<RegisterBloc>(context)
                                .add(TypeLastName(value)),
                        label: 'Apellido',
                        helper: 'Minimo 3 caracteres (solo letras)',
                        formatter: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z]+')),
                        ],
                      ),
                      CustomFormField(
                        size: size,
                        onChanged: (value) =>
                            BlocProvider.of<RegisterBloc>(context)
                                .add(TypePhone(value)),
                        label: 'Telefono',
                        helper: 'Numero de 10 digitos',
                        formatter: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        inputType: TextInputType.number,
                      ),
                      CustomFormField(
                        size: size,
                        pass: true,
                        onChanged: (value) =>
                            BlocProvider.of<RegisterBloc>(context)
                                .add(TypePassword(value)),
                        helper: 'Minimo 6 caracteres',
                        label: 'Contraseña',
                      ),
                      BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          return CustomFormField(
                            size: size,
                            pass: true,
                            onChanged: (value) =>
                                BlocProvider.of<RegisterBloc>(context)
                                    .add(ConfirmationPass(value)),
                            label: 'Confirmar contraseña',
                          );
                        },
                      ),
                    ],
                  ),
                  BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                      return BlocListener<RegisterBloc, RegisterState>(
                        listener: (context, state) {
                          if (state.success) {
                            pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                            customSnackbar(context,
                                message: 'Registro completado!', type: 'ok');
                          } else if (state.failure) {
                            customSnackbar(context,
                                message: 'Ups! algo salio mal', type: 'error');
                          }
                        },
                        child: CustomButton(
                          size: size,
                          color: state.loading
                              ? ColorPalette.unFocused
                              : ColorPalette.primary,
                          onPressed: state.loading
                              ? null
                              : state.lastName.isNotEmpty &&
                                      state.name.isNotEmpty &&
                                      state.password.isNotEmpty &&
                                      state.confirmationPass.isNotEmpty &&
                                      state.phone.isNotEmpty
                                  ? () {
                                      if (state.name.length >= 3) {
                                        if (state.lastName.length >= 3) {
                                          if (state.phone.length == 10) {
                                            if (state.password.length >= 6) {
                                              if (state.password ==
                                                  state.confirmationPass) {
                                                contractAlert(context);
                                              } else {
                                                customSnackbar(context,
                                                    message:
                                                        'Las contraseñas deben coincidir',
                                                    type: 'error');
                                              }
                                            } else {
                                              customSnackbar(context,
                                                  message:
                                                      'Contraseña muy corta',
                                                  subtittle:
                                                      '${state.password.length}/6 caracteres como minimo',
                                                  type: 'error');
                                            }
                                          } else {
                                            customSnackbar(context,
                                                message: 'Telefono no valido',
                                                subtittle:
                                                    '${state.phone.length}/10 digitos',
                                                type: 'error');
                                          }
                                        } else {
                                          customSnackbar(context,
                                              message: 'Apellido no valido',
                                              subtittle:
                                                  '${state.lastName.length}/3 caracteres como minimo',
                                              type: 'error');
                                        }
                                      } else {
                                        customSnackbar(context,
                                            message: 'Nombre no valido',
                                            subtittle:
                                                '${state.name.length}/3 caracteres como minimo',
                                            type: 'error');
                                      }
                                    }
                                  : null,
                          child: state.loading
                              ? const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: ColorPalette.primary,
                                  ),
                                )
                              : Text(
                                  'Registrarse',
                                  style: TextStyle(
                                      color: state.lastName.isNotEmpty &&
                                              state.name.isNotEmpty &&
                                              state.password.isNotEmpty &&
                                              state.confirmationPass
                                                  .isNotEmpty &&
                                              state.phone.isNotEmpty
                                          ? ColorPalette.textColor
                                          : ColorPalette.unFocused),
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Tittle extends StatelessWidget {
  const Tittle({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Registro',
                style: TextStyle(
                  color: ColorPalette.textColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Crea tu cuenta aqui',
                style: TextStyle(
                  color: ColorPalette.textColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
    required this.size,
    required this.pageController,
  });

  final Size size;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<RegisterBloc>(context).add(const ResetForm());
              pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  color: ColorPalette.lightBg,
                  borderRadius: BorderRadius.circular(10)),
              child: const Padding(
                padding: EdgeInsets.only(right: 0),
                child: Icon(
                  Remix.arrow_left_s_line,
                  color: ColorPalette.primary,
                ),
              ),
            ),
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}

Future<dynamic> contractAlert(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: ColorPalette.background,
        title: const Text(
          'Terminos y condiciones',
          style: TextStyle(color: ColorPalette.textColor),
        ),
        content: const Text(
          'Acepta que la información que acaba de ingresar y la ubicación de su telefono sean usadas unica y exclusivamente para las operaciones de servicio a domicilio realizadas a traves de Blitz.',
          textAlign: TextAlign.justify,
          style: TextStyle(color: ColorPalette.textColor),
        ),
        actions: [
          TextButton(
            style:
                TextButton.styleFrom(foregroundColor: ColorPalette.unFocused),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cerrar'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: ColorPalette.primary),
            onPressed: () {
              Navigator.of(context).pop();
              BlocProvider.of<RegisterBloc>(context).add(const ValidateForm());
            },
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
}
