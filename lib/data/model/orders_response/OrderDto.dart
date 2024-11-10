import 'package:trendista_e_commerce/domain/entities/order_entity.dart';

class OrderDto {
  OrderDto({
    this.id,
    this.total,
    this.date,
    this.status,
  });

  OrderDto.fromJson(dynamic json) {
    id = json['id'].toInt();
    total = json['total'].toInt();
    date = json['date'];
    status = json['status'];
  }
  int? id;
  int? total;
  String? date;
  String? status;
  OrderDto copyWith({
    int? id,
    int? total,
    String? date,
    String? status,
  }) =>
      OrderDto(
        id: id ?? this.id,
        total: total ?? this.total,
        date: date ?? this.date,
        status: status ?? this.status,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['total'] = total;
    map['date'] = date;
    map['status'] = status;
    return map;
  }

  OrderEntity toOrderEntity() {
    return OrderEntity(
      id: id,
      total: total,
      date: date,
      status: status,
    );
  }
}
