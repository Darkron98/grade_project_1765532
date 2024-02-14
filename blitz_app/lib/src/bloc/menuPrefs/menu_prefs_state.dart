part of 'menu_prefs_bloc.dart';

class MenuPrefsState extends Equatable {
  const MenuPrefsState({
    this.dishName = '',
    this.price = 0,
    this.description = '',
    this.labelImg = '',
    this.imgPath = '',
    this.selectCategory = '',
    this.stateFlag = false,
    this.categories = const [],
    this.loadingCategories = false,
    this.loadingCreate = false,
  });

  final String dishName;
  final String description;
  final String labelImg;
  final String imgPath;
  final String selectCategory;

  final double price;

  final bool stateFlag;

  final bool loadingCreate;
  final bool loadingCategories;

  final List<Category> categories;

  MenuPrefsState copyWith({
    String? dishName,
    double? price,
    String? description,
    String? labelImg,
    String? imgPath,
    String? selectCategory,
    bool? stateFlag,
    bool? loadingCreate,
    bool? loadingCategories,
    List<Category>? categories,
  }) =>
      MenuPrefsState(
        dishName: dishName ?? this.dishName,
        price: price ?? this.price,
        description: description ?? this.description,
        labelImg: labelImg ?? this.labelImg,
        imgPath: imgPath ?? this.imgPath,
        stateFlag: stateFlag ?? this.stateFlag,
        categories: categories ?? this.categories,
        loadingCategories: loadingCategories ?? this.loadingCategories,
        loadingCreate: loadingCreate ?? this.loadingCreate,
        selectCategory: selectCategory ?? this.selectCategory,
      );

  @override
  List<Object> get props => [
        dishName,
        price,
        description,
        labelImg,
        imgPath,
        stateFlag,
        categories,
        loadingCreate,
        loadingCategories,
        selectCategory,
      ];
}
