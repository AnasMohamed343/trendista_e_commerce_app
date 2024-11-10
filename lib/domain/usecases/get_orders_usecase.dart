import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/model/order_details_response/OrderDetailsResponse.dart';
import 'package:trendista_e_commerce/domain/entities/order_entity.dart';
import 'package:trendista_e_commerce/domain/repository/orders_repository.dart';

@injectable
class GetOrdersUseCase {
  OrdersRepository ordersRepository;
  @factoryMethod
  GetOrdersUseCase({required this.ordersRepository});
  Future<List<OrderEntity>> invoke() {
    return ordersRepository.getOrders();
  }

  Future<List<OrderEntity>> addOrder() {
    return ordersRepository.addOrder();
  }

  Future<List<OrderEntity>> cancelOrder(int orderId) {
    return ordersRepository.cancelOrder(orderId);
  }

  Future<OrderDetailsResponse> getOrderDetails(int orderId) {
    return ordersRepository.getOrderDetails(orderId);
  }
}
