part of 'order_bloc.dart';

class OrderState extends Equatable {
  const OrderState({
    this.selectedCategory = 0,
    this.startIndex = -1,
    this.sortWord = '',
    this.observation = '',
    this.loadingMenu = false,
    this.moveSwiper = false,
    this.itemAdded = false,
    this.loadingOrder = false,
    this.loadingOrders = false,
    this.success = false,
    this.failure = false,
    this.updateSuccess = false,
    this.takeSuccess = false,
    this.cancelSuccess = false,
    this.shippingSuccess = false,
    this.menu = const [],
    this.orderItems = const [],
    this.orders = const [],
  });

  final int selectedCategory;
  final int startIndex;

  final String sortWord;
  final String observation;

  final bool loadingMenu;
  final bool moveSwiper;
  final bool itemAdded;
  final bool loadingOrder;
  final bool loadingOrders;
  final bool success;
  final bool failure;
  final bool updateSuccess;
  final bool takeSuccess;
  final bool cancelSuccess;
  final bool shippingSuccess;

  final List<CategoryDishes> menu;
  final List<OrderItem> orderItems;
  final List<OrderResp> orders;

  OrderState copyWith({
    int? selectedCategory,
    int? startIndex,
    String? sortWord,
    String? observation,
    bool? loadingMenu,
    bool? moveSwiper,
    bool? itemAdded,
    bool? loadingOrder,
    bool? loadingOrders,
    bool? success,
    bool? failure,
    bool? updateSuccess,
    bool? takeSuccess,
    bool? cancelSuccess,
    bool? shippingSuccess,
    List<CategoryDishes>? menu,
    List<OrderItem>? orderItems,
    List<OrderResp>? orders,
  }) =>
      OrderState(
          selectedCategory: selectedCategory ?? this.selectedCategory,
          startIndex: startIndex ?? this.startIndex,
          sortWord: sortWord ?? this.sortWord,
          observation: observation ?? this.observation,
          loadingMenu: loadingMenu ?? this.loadingMenu,
          moveSwiper: moveSwiper ?? this.moveSwiper,
          itemAdded: itemAdded ?? this.itemAdded,
          loadingOrder: loadingOrder ?? this.loadingOrder,
          loadingOrders: loadingOrders ?? this.loadingOrders,
          success: success ?? this.success,
          failure: failure ?? this.failure,
          updateSuccess: updateSuccess ?? this.updateSuccess,
          takeSuccess: takeSuccess ?? this.takeSuccess,
          cancelSuccess: cancelSuccess ?? this.cancelSuccess,
          shippingSuccess: shippingSuccess ?? this.shippingSuccess,
          menu: menu ?? this.menu,
          orderItems: orderItems ?? this.orderItems,
          orders: orders ?? this.orders);

  @override
  List<Object> get props => [
        selectedCategory,
        startIndex,
        sortWord,
        observation,
        loadingMenu,
        moveSwiper,
        itemAdded,
        loadingOrder,
        loadingOrders,
        success,
        failure,
        updateSuccess,
        takeSuccess,
        cancelSuccess,
        shippingSuccess,
        menu,
        orderItems,
        orders,
      ];
}
