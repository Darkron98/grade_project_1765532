class OrderItem {
  const OrderItem({
    this.idUser = 0,
    this.idOrder = 0,
    this.idProduct = 0,
    this.howMany = 0,
    this.price = 0.0,
  });
  final int idUser;
  final int idOrder;
  final int idProduct;
  final int howMany;
  final double price;

  OrderItem copyWith({
    int? idUser,
    int? idOrder,
    int? idProduct,
    int? howMany,
    double? price,
  }) =>
      OrderItem(
        idUser: idUser ?? this.idUser,
        idOrder: idOrder ?? this.idOrder,
        idProduct: idProduct ?? this.idProduct,
        howMany: howMany ?? this.howMany,
        price: price ?? this.price,
      );
}
