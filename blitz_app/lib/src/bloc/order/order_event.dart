part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class SelectCategory extends OrderEvent {
  const SelectCategory(this.index);
  final int index;
  @override
  List<Object> get props => [index];
}

class GetMenu extends OrderEvent {
  @override
  List<Object> get props => [];
}

class SortMenu extends OrderEvent {
  const SortMenu(this.controller);
  final SwiperController controller;
  @override
  List<Object> get props => [controller];
}

class SortWord extends OrderEvent {
  const SortWord(this.sortWord);
  final String sortWord;
  @override
  List<Object> get props => [sortWord];
}

class AddOrderItem extends OrderEvent {
  const AddOrderItem(this.index);
  final int index;
  @override
  List<Object> get props => [index];
}

class ModifyItemQuatity extends OrderEvent {
  const ModifyItemQuatity({
    required this.index,
    required this.operation,
  });
  final String operation;
  final int index;
  @override
  List<Object> get props => [
        index,
        operation,
      ];
}

class TypeObservations extends OrderEvent {
  const TypeObservations(this.text);
  final String text;
  @override
  List<Object> get props => [text];
}

class SubmmitOrder extends OrderEvent {
  @override
  List<Object> get props => [];
}

class GetOrderList extends OrderEvent {
  @override
  List<Object> get props => [];
}

class UpdateOrder extends OrderEvent {
  const UpdateOrder({
    required this.index,
    required this.operation,
  });
  final String operation;
  final int index;
}

class GetOrderItems extends OrderEvent {
  const GetOrderItems(this.index);
  final int index;
  @override
  List<Object> get props => [index];
}
