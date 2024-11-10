import 'package:trendista_e_commerce/data/model/order_details_response/OrderDetailsResponse.dart';
import 'package:trendista_e_commerce/domain/entities/order_entity.dart';

abstract class OrdersRepository {
  Future<List<OrderEntity>> getOrders();

  Future<List<OrderEntity>> addOrder();

  Future<List<OrderEntity>> cancelOrder(int orderId);

  Future<OrderDetailsResponse> getOrderDetails(int orderId);
}
