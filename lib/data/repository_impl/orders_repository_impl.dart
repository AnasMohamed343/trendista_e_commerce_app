import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/datasource_contract/orders_datasource.dart';
import 'package:trendista_e_commerce/data/model/order_details_response/OrderDetailsResponse.dart';
import 'package:trendista_e_commerce/domain/entities/order_entity.dart';
import 'package:trendista_e_commerce/domain/repository/orders_repository.dart';

@Injectable(as: OrdersRepository)
class OrdersRepositoryImpl extends OrdersRepository {
  OrdersDatasource ordersDatasource;
  @factoryMethod
  OrdersRepositoryImpl({required this.ordersDatasource});
  @override
  Future<List<OrderEntity>> getOrders() {
    return ordersDatasource.getOrders();
  }

  @override
  Future<List<OrderEntity>> addOrder() {
    return ordersDatasource.addOrder();
  }

  @override
  Future<List<OrderEntity>> cancelOrder(int orderId) {
    return ordersDatasource.cancelOrder(orderId);
  }

  @override
  Future<OrderDetailsResponse> getOrderDetails(int orderId) {
    return ordersDatasource.getOrderDetails(orderId);
  }
}
