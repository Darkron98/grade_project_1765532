import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grade_project_1765532/src/core/model/cart/item_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
