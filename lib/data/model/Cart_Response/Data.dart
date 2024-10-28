import 'CartItems.dart';

class Data {
  Data({
    this.cartItems,
    this.subTotal,
    this.total,
  });

  Data.fromJson(dynamic json) {
    if (json['cart_items'] != null) {
      cartItems = [];
      json['cart_items'].forEach((v) {
        cartItems?.add(CartItems.fromJson(v));
      });
    }
    subTotal = json['sub_total'] != null ? json['sub_total'].toInt() : 0;
    total = json['total'] != null ? json['total'].toInt() : 0;
  }
  List<CartItems>? cartItems;
  int? subTotal;
  int? total;
  Data copyWith({
    List<CartItems>? cartItems,
    int? subTotal,
    int? total,
  }) =>
      Data(
        cartItems: cartItems ?? this.cartItems,
        subTotal: subTotal ?? this.subTotal,
        total: total ?? this.total,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (cartItems != null) {
      map['cart_items'] = cartItems?.map((v) => v.toJson()).toList();
    }
    map['sub_total'] = subTotal;
    map['total'] = total;
    return map;
  }
}
