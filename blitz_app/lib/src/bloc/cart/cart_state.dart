part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState({
    this.orderItems = const [],
  });
  final List<OrderItem> orderItems;

  CartState copyWith({
    List<OrderItem>? orderItems,
  }) =>
      CartState(
        orderItems: orderItems ?? this.orderItems,
      );
  @override
  List<Object> get props => [
        orderItems,
      ];
}
