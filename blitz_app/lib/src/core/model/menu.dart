class MenuReq {
  MenuReq({
    this.dishName = '',
    this.price = 0,
    this.description = '',
    this.labelImg = '',
    this.categoryId = '',
  });

  final String dishName;
  final double price;
  final String description;
  final String labelImg;
  final String categoryId;

  MenuReq copyWith({
    String? dishName,
    double? price,
    String? description,
    String? labelImg,
    String? categoryId,
  }) =>
      MenuReq(
        dishName: dishName ?? this.dishName,
        price: price ?? this.price,
        description: description ?? this.description,
        labelImg: labelImg ?? this.labelImg,
        categoryId: categoryId ?? this.categoryId,
      );
}

class MenuResp {
  MenuResp({
    this.dishId = '',
    this.dishName = '',
    this.price = 0,
    this.description = '',
    this.labelImg = '',
    this.categoryId = '',
  });

  final String dishId;
  final String dishName;
  final int price;
  final String description;
  final String labelImg;
  final String categoryId;

  MenuResp copyWith({
    String? dishId,
    String? dishName,
    int? price,
    String? description,
    String? labelImg,
    String? categoryId,
  }) =>
      MenuResp(
        dishId: dishId ?? this.dishId,
        dishName: dishName ?? this.dishName,
        price: price ?? this.price,
        description: description ?? this.description,
        labelImg: labelImg ?? this.labelImg,
        categoryId: categoryId ?? this.categoryId,
      );
}

class Category {
  Category({
    this.categoryId = '',
    this.categoryName = '',
  });

  final String categoryId;
  final String categoryName;

  Category copyWith({
    String? categoryId,
    String? categoryName,
  }) =>
      Category(
        categoryId: categoryId ?? this.categoryId,
        categoryName: categoryName ?? this.categoryName,
      );
}

class DishUpdate {
  DishUpdate({
    this.dishName,
    this.description,
    this.labelImage,
    this.price,
    this.categoryId,
    this.dishId,
  });
  final String? dishId;
  final String? dishName;
  final String? description;
  final String? labelImage;
  final String? categoryId;
  final double? price;

  DishUpdate copyWith({
    String? dishId,
    String? dishName,
    String? description,
    String? labelImage,
    String? categoryId,
    double? price,
  }) =>
      DishUpdate(
        dishId: dishId ?? this.dishId,
        dishName: dishName ?? this.dishName,
        description: description ?? this.description,
        labelImage: labelImage ?? this.labelImage,
        price: price ?? this.price,
        categoryId: categoryId ?? this.categoryId,
      );
}
