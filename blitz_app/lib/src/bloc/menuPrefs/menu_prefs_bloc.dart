import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grade_project_1765532/src/core/model/menu.dart';
import 'package:grade_project_1765532/src/core/service/menu_services.dart';
import 'package:grade_project_1765532/src/core/service/pick_img.dart';
import 'package:image_picker/image_picker.dart';

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
        if (event.imgaPath.isNotEmpty) {
          emit(state.copyWith(imgPath: event.imgaPath));
          print(state.imgPath);
        }
      },
    );
    on<Submitt>((event, emit) async {
      if (state.imgPath.isNotEmpty) {
        emit(state.copyWith(loadingCreate: true));
        if (state.imgPath.isNotEmpty) {
          var url = await MenuService().uploadImg(state.imgPath);
          emit(state.copyWith(labelImg: url));
        }
        var response = await MenuService().createDish(MenuReq(
          dishName: state.dishName,
          price: state.price,
          description: state.description,
          labelImg: state.labelImg,
          categoryId: state.selectCategory,
        ));

        emit(state.copyWith(loadingCreate: false));
        if (response.startsWith('2')) {
          emit(const MenuPrefsState());
        }
      }
    });
    on<LoadCategories>((event, emit) async {
      emit(state.copyWith(loadingCategories: true));
      emit(state.copyWith(categories: await MenuService().getMenuCategories()));
      emit(state.copyWith(loadingCategories: false));
    });
    on<SelectCategory>(
      (event, emit) {
        emit(state.copyWith(
            selectCategory: state.categories[event.index].categoryId));
      },
    );
  }
}
