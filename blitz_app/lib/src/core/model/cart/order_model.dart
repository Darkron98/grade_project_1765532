class Order {
  Order({
    this.orderId = 0,
    this.orderLat = 0,
    this.orderLng = 0,
    this.comments = '',
  });
  final int orderId;
  final double orderLat;
  final double orderLng;
  final String comments;
  Order copyWith({
    int? orderId,
    double? orderLat,
    double? orderLng,
    String? comments,
  }) =>
      Order(
        orderId: orderId ?? this.orderId,
        orderLat: orderLat ?? this.orderLat,
        orderLng: orderLng ?? this.orderLng,
        comments: comments ?? this.comments,
      );
}
