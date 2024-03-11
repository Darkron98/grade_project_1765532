class OrderReq {
  OrderReq({
    required this.addressName,
    required this.lat,
    required this.lng,
    required this.totalPrice,
    required this.observations,
    required this.deliveryId,
    this.items = const [],
  });
  final String addressName;
  final double lat;
  final double lng;
  final double totalPrice;
  final String observations;
  final String deliveryId;
  final List<OrderItem> items;
}

class OrderItem {
  OrderItem({
    required this.itemDesc,
    required this.itemId,
    required this.labelImg,
    required this.quantity,
    required this.unitPrice,
  });
  final String itemDesc;
  final String itemId;
  final String labelImg;
  final int quantity;
  final double unitPrice;

  OrderItem copyWith({
    String? itemDesc,
    String? itemId,
    String? observations,
    String? labelImg,
    int? quantity,
    double? unitPrice,
  }) =>
      OrderItem(
        itemDesc: itemDesc ?? this.itemDesc,
        itemId: itemId ?? this.itemId,
        labelImg: labelImg ?? this.labelImg,
        quantity: quantity ?? this.quantity,
        unitPrice: unitPrice ?? this.unitPrice,
      );
}

class OrderResp {
  OrderResp({
    required this.id,
    required this.owner,
    required this.ownerId,
    required this.state,
    required this.date,
    required this.taken,
    required this.canceled,
    required this.addressName,
    required this.lat,
    required this.lng,
    required this.totalPrice,
    required this.observations,
    required this.deliveryId,
    this.items = const [],
  });
  final String id;
  final String addressName;
  final double lat;
  final double lng;
  final double totalPrice;
  final String observations;
  final String deliveryId;
  final String owner;
  final String ownerId;
  final bool state;
  final DateTime date;
  final bool taken;
  final bool canceled;
  final List<OrderItem> items;

  set items(List<OrderItem> items) {
    this.items = items;
  }

  set deliveryId(String id) {
    deliveryId = id;
  }

  set state(bool state) {
    this.state = state;
  }

  set taken(bool taken) {
    this.taken = taken;
  }

  set canceled(bool canceled) {
    this.canceled = canceled;
  }

  OrderResp copyWith({
    String? id,
    String? addressName,
    double? lat,
    double? lng,
    double? totalPrice,
    String? observations,
    String? deliveryId,
    String? owner,
    String? ownerId,
    bool? state,
    DateTime? date,
    bool? taken,
    bool? canceled,
    List<OrderItem>? items,
  }) =>
      OrderResp(
        id: id ?? this.id,
        owner: owner ?? this.owner,
        ownerId: ownerId ?? this.ownerId,
        state: state ?? this.state,
        date: date ?? this.date,
        taken: taken ?? this.taken,
        canceled: canceled ?? this.canceled,
        addressName: addressName ?? this.addressName,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        totalPrice: totalPrice ?? this.totalPrice,
        observations: observations ?? this.observations,
        deliveryId: deliveryId ?? this.deliveryId,
      );
}
