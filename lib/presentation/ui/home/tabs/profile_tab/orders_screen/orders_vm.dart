import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/model/order_details_response/OrderDetailsResponse.dart';
import 'package:trendista_e_commerce/domain/entities/order_entity.dart';
import 'package:trendista_e_commerce/domain/usecases/get_orders_usecase.dart';

@injectable
class OrdersViewModel extends Cubit<OrdersState> {
  GetOrdersUseCase getOrdersUseCase;
  @factoryMethod
  OrdersViewModel({required this.getOrdersUseCase})
      : super(OrdersLoadingState());

  void getOrders() async {
    try {
      var orders = await getOrdersUseCase.invoke();
      emit(OrdersSuccessState(orders: orders));
    } catch (e) {
      emit(OrdersErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> addOrder() async {
    emit(OrdersLoadingState());
    try {
      //await getOrdersUseCase.addOrder();
      var orders = await getOrdersUseCase.addOrder();
      emit(OrdersSuccessState(orders: orders));
    } catch (e) {
      print('error at OrdersViewModel: $e');
      emit(OrdersErrorState(errorMessage: e.toString()));
    }
  }

  void cancelOrder(int orderId) async {
    emit(OrdersLoadingState());
    try {
      await getOrdersUseCase.cancelOrder(orderId);
      getOrders(); // Call getOrders to refresh the list
    } catch (e) {
      print('error at OrdersViewModel: $e');
      emit(OrdersErrorState(errorMessage: e.toString()));
    }
  }

  void getOrderDetails(int orderId) async {
    emit(OrdersLoadingState());
    try {
      var orderDetails = await getOrdersUseCase.getOrderDetails(orderId);
      emit(OrdersSuccessState(
        orderDetailsResponse: orderDetails,
      ));
    } catch (e) {
      print('error at OrdersViewModel: $e');
      emit(OrdersErrorState(errorMessage: e.toString()));
    }
  }

  @override
  void onChange(Change<OrdersState> change) {
    super.onChange(change);
    print(change);
  }
}

sealed class OrdersState {}

class OrdersLoadingState extends OrdersState {}

class OrdersErrorState extends OrdersState {
  String? errorMessage;
  OrdersErrorState({this.errorMessage});
}

class OrdersSuccessState extends OrdersState {
  List<OrderEntity>? orders;
  final OrderDetailsResponse? orderDetailsResponse;
  OrdersSuccessState({this.orders, this.orderDetailsResponse});
}
