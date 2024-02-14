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
  });

  final String dishId;
  final String dishName;
  final double price;
  final String description;
  final String labelImg;

  MenuResp copyWith({
    String? dishId,
    String? dishName,
    double? price,
    String? description,
    String? labelImg,
  }) =>
      MenuResp(
        dishId: dishId ?? this.dishId,
        dishName: dishName ?? this.dishName,
        price: price ?? this.price,
        description: description ?? this.description,
        labelImg: labelImg ?? this.labelImg,
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
