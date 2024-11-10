import 'Address.dart';
import 'product_order_details_Dto.dart';

class Data {
  Data({
    this.id,
    this.cost,
    this.discount,
    this.points,
    this.vat,
    this.total,
    this.pointsCommission,
    this.promoCode,
    this.paymentMethod,
    this.date,
    this.status,
    this.address,
    this.products,
  });

  Data.fromJson(dynamic json) {
    id = json['id'] is int ? json['id'] : (json['id'] as double?)?.toInt();
    cost =
        json['cost'] is int ? json['cost'] : (json['cost'] as double?)?.toInt();
    discount = json['discount'] is int
        ? json['discount']
        : (json['discount'] as double?)?.toInt();
    points = json['points'] is int
        ? json['points']
        : (json['points'] as double?)?.toInt();
    vat =
        json['vat'] is double ? json['vat'] : (json['vat'] as int?)?.toDouble();
    total = json['total'] is int
        ? json['total']
        : (json['total'] as double?)?.toInt();
    pointsCommission = json['points_commission'] is int
        ? json['points_commission']
        : (json['points_commission'] as double?)?.toInt();
    promoCode = json['promo_code'];
    paymentMethod = json['payment_method'];
    date = json['date'];
    status = json['status'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(ProductOrderDetailsDto.fromJson(v));
      });
    }
  }
  int? id;
  int? cost;
  int? discount;
  int? points;
  double? vat;
  int? total;
  int? pointsCommission;
  String? promoCode;
  String? paymentMethod;
  String? date;
  String? status;
  Address? address;
  List<ProductOrderDetailsDto>? products;
  Data copyWith({
    int? id,
    int? cost,
    int? discount,
    int? points,
    double? vat,
    int? total,
    int? pointsCommission,
    String? promoCode,
    String? paymentMethod,
    String? date,
    String? status,
    Address? address,
    List<ProductOrderDetailsDto>? products,
  }) =>
      Data(
        id: id ?? this.id,
        cost: cost ?? this.cost,
        discount: discount ?? this.discount,
        points: points ?? this.points,
        vat: vat ?? this.vat,
        total: total ?? this.total,
        pointsCommission: pointsCommission ?? this.pointsCommission,
        promoCode: promoCode ?? this.promoCode,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        date: date ?? this.date,
        status: status ?? this.status,
        address: address ?? this.address,
        products: products ?? this.products,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['cost'] = cost;
    map['discount'] = discount;
    map['points'] = points;
    map['vat'] = vat;
    map['total'] = total;
    map['points_commission'] = pointsCommission;
    map['promo_code'] = promoCode;
    map['payment_method'] = paymentMethod;
    map['date'] = date;
    map['status'] = status;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
