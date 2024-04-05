// ignore_for_file: unused_local_variable

import 'package:bloc/bloc.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:equatable/equatable.dart';
import 'package:grade_project_1765532/src/core/model/menu.dart';
import 'package:grade_project_1765532/src/core/service/menu_services.dart';

import '../../core/logic/functions.dart';
import '../../core/model/cart/order.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const OrderState()) {
    on<SelectCategory>((event, emit) async {
      emit(state.copyWith(
          loadingMenu: true, selectedCategory: event.index, startIndex: -1));
      var awaiter = await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(loadingMenu: false));
    });
    on<GetMenu>(
      (event, emit) async {
        emit(state.copyWith(loadingMenu: true));
        List<CategoryDishes> data = await MenuService().getWithCategories();
        emit(state.copyWith(menu: data));
        emit(state.copyWith(loadingMenu: false));
      },
    );
    on<SortMenu>(
      (event, emit) async {
        if (state.sortWord.isNotEmpty) {
          emit(state.copyWith(loadingMenu: true));
          var awaiter = await Future.delayed(const Duration(milliseconds: 500));
          String searchText = state.sortWord.toLowerCase();
          int index = state.menu[state.selectedCategory].dishes.indexWhere(
              (dish) => dish.dishName.toLowerCase().contains(searchText));
          if (index != -1) {
            emit(state.copyWith(
                startIndex:
                    (state.menu[state.selectedCategory].dishes.length - 1) +
                        index));
          }
          emit(state.copyWith(loadingMenu: false, sortWord: ''));
        }
      },
    );
    on<SortWord>(
      (event, emit) => emit(state.copyWith(sortWord: event.sortWord)),
    );
    on<AddOrderItem>(
      (event, emit) {
        List<OrderItem> items = state.orderItems.toList();
        MenuResp dish = state.menu[state.selectedCategory].dishes[event.index];
        OrderItem item = OrderItem(
            itemDesc: dish.dishName,
            itemId: dish.dishId,
            labelImg: dish.labelImg,
            quantity: 1,
            unitPrice: dish.price.toDouble());
        int index =
            state.orderItems.indexWhere((e) => e.itemId.contains(item.itemId));
        if (index == -1 && items.length < 9) {
          items.add(item);
          emit(state.copyWith(itemAdded: true));
        } else if (index >= 0) {
          if (items[index].quantity < 10) {
            OrderItem copyItem = items[index].copyWith(
              quantity: items[index].quantity + 1,
            );
            items[index] = copyItem;
            emit(state.copyWith(itemAdded: true));
          }
        }
        emit(state.copyWith(orderItems: items, itemAdded: false));
      },
    );
    on<ModifyItemQuatity>(
      (event, emit) {
        List<OrderItem> items = state.orderItems.toList();
        OrderItem item;
        if (event.operation == 'add') {
          item = state.orderItems[event.index]
              .copyWith(quantity: state.orderItems[event.index].quantity + 1);
        } else {
          item = state.orderItems[event.index]
              .copyWith(quantity: state.orderItems[event.index].quantity - 1);
        }
        if (item.quantity <= 10) {
          items[event.index] = item;
        }
        items.removeWhere((item) => item.quantity <= 0);
        emit(state.copyWith(orderItems: items));
      },
    );
    on<TypeObservations>(
        (event, emit) => emit(state.copyWith(observation: event.text)));
    on<SubmmitOrder>(
      (event, emit) async {
        emit(state.copyWith(loadingOrder: true));
        double totalPrice = 0;
        List<OrderItem> items = state.orderItems;
        items.map((e) => totalPrice = totalPrice + e.unitPrice * e.quantity);
        OrderReq order = OrderReq(
          addressName: '',
          lat: await getLocationLat(),
          lng: await getLocationLong(),
          totalPrice: totalPrice,
          observations: state.observation,
          deliveryId: '',
          items: items,
        );
        var response = await MenuService().createOrder(order);
        emit(state.copyWith(
          success: response.startsWith('2'),
          failure: !RegExp(r'^2').hasMatch(response),
        ));
        if (state.success) {
          emit(OrderState(menu: state.menu));
        }
        emit(state.copyWith(loadingOrder: false));
      },
    );
    on<GetOrderList>(
      (event, emit) async {
        emit(state.copyWith(loadingOrders: true));
        List<OrderResp> resp = await MenuService().getOrders();
        emit(state.copyWith(orders: resp));
        emit(state.copyWith(loadingOrders: false));
      },
    );
    on<UpdateOrder>(
      (event, emit) async {
        String id = state.orders[event.index].id;
        String user = state.orders[event.index].owner;
        String resp;
        emit(state.copyWith(loadingOrders: true));
        switch (event.operation) {
          case ('take'):
            resp = await MenuService().takeOrder(id, user);
            List<OrderResp> resp2 = await MenuService().getOrders();
            emit(state.copyWith(orders: [], takeSuccess: resp.startsWith('2')));
            emit(state.copyWith(orders: resp2, takeSuccess: false));
            emit(state.copyWith(loadingOrders: false));
            break;
          case ('ship'):
            resp = await MenuService().orderShipped(id, user);
            List<OrderResp> resp2 = await MenuService().getOrders();
            emit(state
                .copyWith(orders: [], shippingSuccess: resp.startsWith('2')));
            emit(state.copyWith(orders: resp2, shippingSuccess: false));
            emit(state.copyWith(loadingOrders: false));
            break;
          case ('cancel'):
            resp = await MenuService().cancelOrder(id);
            List<OrderResp> resp2 = await MenuService().getOrders();
            emit(state
                .copyWith(orders: [], cancelSuccess: resp.startsWith('2')));
            emit(state.copyWith(orders: resp2, cancelSuccess: false));
            emit(state.copyWith(loadingOrders: false));
            break;
          default:
            break;
        }
      },
    );
    on<GetOrderItems>(
      (event, emit) async {
        List<OrderItem> resp =
            await MenuService().getItemsByOrderId(state.orders[event.index].id);
        List<OrderResp> orders = state.orders.toList();
        OrderResp order = OrderResp(
          id: orders[event.index].id,
          owner: orders[event.index].owner,
          ownerId: orders[event.index].ownerId,
          state: orders[event.index].state,
          date: orders[event.index].date,
          taken: orders[event.index].taken,
          canceled: orders[event.index].canceled,
          addressName: orders[event.index].addressName,
          lat: orders[event.index].lat,
          lng: orders[event.index].lng,
          totalPrice: orders[event.index].totalPrice,
          observations: orders[event.index].observations,
          deliveryId: orders[event.index].deliveryId,
          items: resp,
        );
        orders[event.index] = order;
        emit(state.copyWith(orders: orders));
      },
    );
  }
}
