part of 'menu_prefs_bloc.dart';

class MenuPrefsState extends Equatable {
  const MenuPrefsState({
    this.dishName = '',
    this.price = 0,
    this.description = '',
    this.labelImg = '',
    this.imgPath = '',
    this.selectCategoryId = '',
    this.selectCategoryName = '',
    this.stateFlag = false,
    this.categories = const [],
    this.menuDishes = const [],
    this.loadingCategories = false,
    this.loadingCreate = false,
    this.failure = false,
    this.success = false,
    this.loadDishes = false,
    this.loadingDelete = false,
    this.delFailure = false,
    this.delSuccess = false,
  });

  final String dishName;
  final String description;
  final String labelImg;
  final String imgPath;
  final String selectCategoryId;
  final String selectCategoryName;

  final double price;

  final bool stateFlag;

  final bool loadingCreate;
  final bool loadingDelete;
  final bool loadingCategories;
  final bool loadDishes;
  final bool success;
  final bool failure;
  final bool delSuccess;
  final bool delFailure;

  final List<Category> categories;
  final List<MenuResp> menuDishes;

  MenuPrefsState copyWith({
    String? dishName,
    double? price,
    String? description,
    String? labelImg,
    String? imgPath,
    String? selectCategoryId,
    String? selectCategoryName,
    bool? stateFlag,
    bool? loadingCreate,
    bool? loadingCategories,
    bool? failure,
    bool? success,
    bool? loadDishes,
    bool? loadingDelete,
    bool? delSuccess,
    bool? delFailure,
    List<Category>? categories,
    List<MenuResp>? menuDishes,
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
        selectCategoryId: selectCategoryId ?? this.selectCategoryId,
        selectCategoryName: selectCategoryName ?? this.selectCategoryName,
        failure: failure ?? this.failure,
        success: success ?? this.success,
        menuDishes: menuDishes ?? this.menuDishes,
        loadDishes: loadDishes ?? this.loadDishes,
        delFailure: delFailure ?? this.delFailure,
        delSuccess: delSuccess ?? this.delSuccess,
        loadingDelete: loadingDelete ?? this.loadingDelete,
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
        selectCategoryId,
        selectCategoryName,
        failure,
        success,
        menuDishes,
        loadDishes,
        delFailure,
        delSuccess,
        loadingDelete,
      ];
}
