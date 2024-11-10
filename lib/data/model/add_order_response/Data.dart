class Data {
  Data({
    this.paymentMethod,
    this.cost,
    this.vat,
    this.discount,
    this.points,
    this.total,
    this.id,
  });

  Data.fromJson(dynamic json) {
    paymentMethod = json['payment_method'];
    cost = json['cost'].toInt();
    vat = json['vat'].toInt();
    discount = json['discount'].toInt();
    points = json['points'].toInt();
    total = json['total'].toInt();
    id = json['id'].toInt();
  }
  String? paymentMethod;
  int? cost;
  double? vat;
  int? discount;
  int? points;
  double? total;
  int? id;
  Data copyWith({
    String? paymentMethod,
    int? cost,
    double? vat,
    int? discount,
    int? points,
    double? total,
    int? id,
  }) =>
      Data(
        paymentMethod: paymentMethod ?? this.paymentMethod,
        cost: cost ?? this.cost,
        vat: vat ?? this.vat,
        discount: discount ?? this.discount,
        points: points ?? this.points,
        total: total ?? this.total,
        id: id ?? this.id,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['payment_method'] = paymentMethod;
    map['cost'] = cost;
    map['vat'] = vat;
    map['discount'] = discount;
    map['points'] = points;
    map['total'] = total;
    map['id'] = id;
    return map;
  }
}
