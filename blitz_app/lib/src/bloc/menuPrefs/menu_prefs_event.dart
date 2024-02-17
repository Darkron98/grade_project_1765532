part of 'menu_prefs_bloc.dart';

class MenuPrefsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DishName extends MenuPrefsEvent {
  DishName(this.dishName);
  final String dishName;
  @override
  List<Object> get props => [dishName];
}

class Price extends MenuPrefsEvent {
  Price(this.price);
  final double price;
  @override
  List<Object> get props => [price];
}

class Description extends MenuPrefsEvent {
  Description(this.description);
  final String description;
  @override
  List<Object> get props => [description];
}

class Submitt extends MenuPrefsEvent {
  Submitt();
  @override
  List<Object> get props => [];
}

class PickImage extends MenuPrefsEvent {
  PickImage(this.imgPath);
  final String imgPath;
  @override
  List<Object> get props => [imgPath];
}

class LoadCategories extends MenuPrefsEvent {
  @override
  List<Object> get props => [];
}

class SelectCategory extends MenuPrefsEvent {
  SelectCategory(this.selectCategoryId, this.selectCategoryName);
  final String selectCategoryId;
  final String selectCategoryName;
  @override
  List<Object> get props => [selectCategoryId];
}

class GetDishes extends MenuPrefsEvent {
  @override
  List<Object> get props => [];
}

class Update extends MenuPrefsEvent {
  Update(this.dishId, this.context);
  final String dishId;
  final BuildContext context;
  @override
  List<Object> get props => [dishId];
}

class Delete extends MenuPrefsEvent {
  Delete(this.dishId);
  final String dishId;
  @override
  List<Object> get props => [dishId];
}

class RestoreFields extends MenuPrefsEvent {
  @override
  List<Object> get props => [];
}
