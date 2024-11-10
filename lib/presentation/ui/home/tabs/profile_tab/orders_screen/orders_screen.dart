import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/styles.dart';
import 'package:trendista_e_commerce/domain/entities/order_entity.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/profile_tab/orders_screen/orders_details.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/profile_tab/orders_screen/orders_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_app_bar.dart';
import 'package:trendista_e_commerce/services/paymob_manager/paymob_manager.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late OrdersViewModel ordersVM;
  @override
  void initState() {
    super.initState();
    ordersVM = context.read<OrdersViewModel>()..getOrders();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: CustomAppBar(appbarTitle: 'Orders'),
        body: BlocBuilder<OrdersViewModel, OrdersState>(
          bloc: ordersVM,
          builder: (context, state) {
            switch (state.runtimeType) {
              case OrdersLoadingState:
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: h * 0.3),
                    child: const CircularProgressIndicator(),
                  ),
                );
              case OrdersErrorState:
                final errorState = state as OrdersErrorState;
                return Center(
                  child: Text(
                    errorState.errorMessage ?? 'Error loading data',
                    style: Styles.textStyle20(context),
                  ),
                );
              case OrdersSuccessState:
                return ListView.builder(
                  itemCount: (state as OrdersSuccessState).orders?.length,
                  itemBuilder: (context, index) {
                    var order = (state as OrdersSuccessState).orders?[index];
                    return GestureDetector(
                      onTap: () {
                        if (order?.id != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrdersDetails(
                                orderId: order?.id ?? 0,
                              ),
                            ),
                          );
                        } else {
                          Fluttertoast.showToast(
                              msg: 'No order found',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: w * 0.02);
                        }
                      },
                      child: Container(
                        height: h * 0.11,
                        margin: EdgeInsets.symmetric(
                            vertical: w * 0.02, horizontal: w * 0.04),
                        padding: EdgeInsets.all(w * 0.02),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text('Total: ${order?.total} EGP',
                                    style: Styles.textStyle20(context)),
                                const Spacer(),
                                Text('${order?.date}',
                                    style: Styles.textStyle20(context)),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: h * 0.04,
                                  width: order?.status == 'Cancelled'
                                      ? w * 0.2
                                      : w * 0.13,
                                  decoration: BoxDecoration(
                                      //color: kBorderColor,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 4,
                                        ),
                                      ]),
                                  child: Text(
                                    '${order?.status}',
                                    style: Styles.textStyle18(context)
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    if (order?.status == 'Cancelled') {
                                      Fluttertoast.showToast(
                                          msg: 'Order already cancelled',
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: w * 0.02);
                                      return;
                                    } else {
                                      ordersVM.cancelOrder(order?.id ?? 0);
                                      Fluttertoast.showToast(
                                          msg: 'Order cancelled successfully',
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: w * 0.02);
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: h * 0.033,
                                    width: w * 0.14,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      'Cancel',
                                      style: Styles.textStyle18(context)
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
            }
            return Container();
          },
        ));
  }
}
