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
  PickImage(this.imgaPath);
  final String imgaPath;
  @override
  List<Object> get props => [imgaPath];
}

class LoadCategories extends MenuPrefsEvent {
  @override
  List<Object> get props => [];
}

class SelectCategory extends MenuPrefsEvent {
  SelectCategory(this.index);
  final int index;
  @override
  List<Object> get props => [index];
}
