import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/api_manager/api_manager.dart';
import 'package:trendista_e_commerce/data/datasource_contract/orders_datasource.dart';
import 'package:trendista_e_commerce/data/model/order_details_response/OrderDetailsResponse.dart';
import 'package:trendista_e_commerce/domain/entities/order_entity.dart';

@Injectable(as: OrdersDatasource)
class OrdersDatasourceImpl extends OrdersDatasource {
  ApiManager apiManager;
  @factoryMethod
  OrdersDatasourceImpl(this.apiManager);
  @override
  Future<List<OrderEntity>> getOrders() async {
    var response = await apiManager.getOrders();
    return response.data?.data?.map((e) => e.toOrderEntity()).toList() ?? [];
  }

  @override
  Future<List<OrderEntity>> addOrder() async {
    var response = await apiManager.addOrder();
    return response.data?.data?.map((e) => e.toOrderEntity()).toList() ?? [];
  }

  @override
  Future<List<OrderEntity>> cancelOrder(int orderId) async {
    var response = await apiManager.cancelOrder(orderId);
    return response.data?.data?.map((e) => e.toOrderEntity()).toList() ?? [];
  }

  @override
  Future<OrderDetailsResponse> getOrderDetails(int orderId) async {
    var response = await apiManager.getOrderDetails(orderId);
    return response;
  }
}
