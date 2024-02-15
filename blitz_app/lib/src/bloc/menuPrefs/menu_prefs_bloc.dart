// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:grade_project_1765532/src/core/logic/functions.dart';
import 'package:grade_project_1765532/src/core/model/menu.dart';
import 'package:grade_project_1765532/src/core/service/menu_services.dart';

import '../../view/widgets/snackbar.dart';

part 'menu_prefs_event.dart';
part 'menu_prefs_state.dart';

class MenuPrefsBloc extends Bloc<MenuPrefsEvent, MenuPrefsState> {
  MenuPrefsBloc() : super(const MenuPrefsState()) {
    on<DishName>((event, emit) {
      emit(state.copyWith(dishName: event.dishName));
    });
    on<Price>((event, emit) {
      emit(state.copyWith(price: event.price));
    });
    on<Description>((event, emit) {
      emit(state.copyWith(description: event.description));
    });
    on<PickImage>(
      (event, emit) async {
        if (event.imgPath.isNotEmpty) {
          emit(state.copyWith(imgPath: event.imgPath));
        }
      },
    );
    on<Submitt>((event, emit) async {
      emit(state.copyWith(loadingCreate: true));
      MenuReq req = MenuReq(
        dishName: state.dishName,
        price: state.price,
        description: state.description,
        labelImg: state.labelImg,
        categoryId: state.selectCategoryId,
      );

      if (!validadeDishcreate(req)) {
        if (state.imgPath.isNotEmpty) {
          var url = await MenuService().uploadImg(state.imgPath);
          emit(state.copyWith(labelImg: url));
          req = req.copyWith(labelImg: url);
        }
        var response = await MenuService().createDish(req);
        emit(state.copyWith(
          success: response.startsWith('2'),
          failure: !RegExp(r'^2').hasMatch(response),
        ));
        if (state.success) {
          emit(const MenuPrefsState());
        }
      }
      emit(
          state.copyWith(loadingCreate: false, success: false, failure: false));
    });
    on<LoadCategories>((event, emit) async {
      emit(state.copyWith(loadingCategories: true));
      emit(state.copyWith(categories: await MenuService().getMenuCategories()));
      emit(state.copyWith(loadingCategories: false));
    });
    on<SelectCategory>(
      (event, emit) {
        emit(state.copyWith(
          selectCategoryId: event.selectCategoryId,
          selectCategoryName: event.selectCategoryName,
        ));
      },
    );
    on<GetDishes>(
      (event, emit) async {
        emit(state.copyWith(loadDishes: true));
        List<MenuResp> resp = await MenuService().getMenuDishes();
        emit(state.copyWith(menuDishes: resp));
        emit(state.copyWith(loadDishes: false));
      },
    );
    on<Update>(
      (event, emit) async {
        emit(state.copyWith(loadingCreate: true));

        DishUpdate req = DishUpdate(
          dishId: event.dishId,
          dishName: state.dishName.isEmpty ? null : state.dishName,
          price: state.price == 0 ? null : state.price,
          description: state.description.isEmpty ? null : state.description,
          labelImage: state.labelImg.isEmpty ? null : state.labelImg,
          categoryId:
              state.selectCategoryId.isEmpty ? null : state.selectCategoryId,
        );

        if (state.imgPath.isNotEmpty) {
          var url = await MenuService().uploadImg(state.imgPath);
          emit(state.copyWith(labelImg: url));
          req = req.copyWith(labelImage: url);
        }
        var response = await MenuService().updateDish(req);
        emit(state.copyWith(
          success: response.startsWith('2'),
          failure: !RegExp(r'^2').hasMatch(response),
        ));
        if (state.success) {
          customSnackbar(event.context,
              message: 'Platillo Actualizado!', type: 'ok');
          emit(const MenuPrefsState());
          emit(state.copyWith(loadDishes: true));
          List<MenuResp> resp = await MenuService().getMenuDishes();
          emit(state.copyWith(menuDishes: resp));
          emit(state.copyWith(loadDishes: false));
        } else if (state.failure) {
          customSnackbar(event.context,
              message: 'Ups! algo salio mal', type: 'error');
        }

        emit(state.copyWith(
            loadingCreate: false, success: false, failure: false));
      },
    );
  }
}
