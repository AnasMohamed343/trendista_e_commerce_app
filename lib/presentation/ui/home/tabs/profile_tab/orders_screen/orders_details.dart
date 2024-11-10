import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/enums/device_type.dart';
import 'package:trendista_e_commerce/core/styles.dart';
import 'package:trendista_e_commerce/core/ui_components/info_widget.dart';
import 'package:trendista_e_commerce/core/utils/routes_manager.dart';
import 'package:trendista_e_commerce/di/di.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/profile_tab/orders_screen/orders_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/profile_tab/orders_screen/widgets/custom_confirmation_order.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_app_bar.dart';
import 'package:trendista_e_commerce/presentation/ui/product_details_screen/product_details_screen.dart';

class OrdersDetails extends StatelessWidget {
  final int orderId;
  const OrdersDetails({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final orderDetailsVM = getIt<OrdersViewModel>()..getOrderDetails(orderId);
    return Scaffold(
      appBar: CustomAppBar(appbarTitle: 'Order Details'),
      body: BlocBuilder<OrdersViewModel, OrdersState>(
        bloc: orderDetailsVM,
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
                child: Text(errorState.errorMessage ?? 'Error loading data'),
              );
            case OrdersSuccessState:
              final successState = state as OrdersSuccessState;
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: w * 0.04,
                          right: w * 0.04,
                          top: w * 0.02,
                          bottom: h * 0.12),
                      child: InfoWidget(
                        builder: (context, deviceInfo) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                successState.orderDetailsResponse?.data
                                            ?.status ==
                                        'New'
                                    ? CustomConfirmationOrderWidget(
                                        confirmMessageTitle: 'Thank you!',
                                        confirmMessage:
                                            'Your order #${successState.orderDetailsResponse?.data?.id} has been confirmed.',
                                        icon: Icons.check_circle,
                                        iconBackgroundColor: Colors.green,
                                      )
                                    : CustomConfirmationOrderWidget(
                                        confirmMessageTitle: 'Canceled Order',
                                        confirmMessage:
                                            'Your order #${successState.orderDetailsResponse?.data?.id} has been Canceled.',
                                        icon: Icons.cancel,
                                        iconBackgroundColor: Colors.red,
                                      ),
                                SizedBox(
                                  height: h * 0.02,
                                ),
                                Text(
                                  'Time Placed: ${successState.orderDetailsResponse?.data?.date}',
                                  style: Styles.textStyle18(context).copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: h * 0.02,
                                ),
                                Text(
                                  'Shipping',
                                  style: Styles.textStyle20(context).copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(height: h * 0.01),
                                Container(
                                  height: deviceInfo.deviceType ==
                                          DeviceType.TallMobile
                                      ? h * 0.17
                                      : deviceInfo.deviceType ==
                                                  DeviceType.Desktop ||
                                              deviceInfo.deviceType ==
                                                  DeviceType.Tablet
                                          ? h * 0.25
                                          : h *
                                              0.20, //ScreenUtil().screenHeight * 0.18,
                                  width: w, //ScreenUtil().screenWidth,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * 0.04, vertical: w * 0.01),
                                  margin: EdgeInsets.all(w * 0.01),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Name: ${successState.orderDetailsResponse?.data?.address?.name ?? 'no name'}',
                                        style: Styles.textStyle16(context)
                                            .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Text(
                                        'Address: ${successState.orderDetailsResponse?.data?.address?.city ?? 'no city'} ,\n ${successState.orderDetailsResponse?.data?.address?.region ?? 'no region'}',
                                        style: Styles.textStyle16(context)
                                            .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Text(
                                        'Details: ${successState.orderDetailsResponse?.data?.address?.details}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: Styles.textStyle16(context)
                                            .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Text(
                                        'Notes: ${successState.orderDetailsResponse?.data?.address?.notes}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: Styles.textStyle16(context)
                                            .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: h * 0.02,
                                ),
                                Text(
                                  'Order Items',
                                  style: Styles.textStyle20(context).copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(
                                  height: h * 0.018,
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: successState.orderDetailsResponse
                                        ?.data?.products?.length,
                                    itemBuilder: (context, index) {
                                      final productId = successState
                                          .orderDetailsResponse
                                          ?.data
                                          ?.products?[index]
                                          .id;
                                      return InkWell(
                                        onTap: () {
                                          if (productId != null) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetailsScreen(
                                                          productId: productId),
                                                ));
                                          } else {
                                            Fluttertoast.showToast(
                                              msg: 'No product found',
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              fontSize: w * 0.02,
                                            );
                                          }
                                        },
                                        child: Container(
                                          //alignment: Alignment.center,
                                          height: deviceInfo.deviceType ==
                                                  DeviceType.TallMobile
                                              ? h * 0.13
                                              : deviceInfo.deviceType ==
                                                          DeviceType.Desktop ||
                                                      deviceInfo.deviceType ==
                                                          DeviceType.Tablet
                                                  ? h * 0.19
                                                  : h *
                                                      0.16, //ScreenUtil().screenHeight * 0.13,
                                          width: w, //ScreenUtil().screenWidth,
                                          decoration: BoxDecoration(
                                            //color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          margin: EdgeInsets.symmetric(
                                              vertical: w * 0.01,
                                              horizontal: 0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CachedNetworkImage(
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  width: w *
                                                      0.25, //ScreenUtil().screenWidth * 0.25,
                                                  height: h *
                                                      0.38, //ScreenUtil().screenHeight * 0.38,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  5)),
                                                      image: DecorationImage(
                                                          image:
                                                              imageProvider)),
                                                ),
                                                imageUrl:
                                                    '${successState.orderDetailsResponse?.data?.products?[index].image}',
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child: Container(
                                                      color: Colors.white,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            w * 0.02),
                                                        child:
                                                            const CircularProgressIndicator(
                                                          color:
                                                              kSecondaryColor,
                                                          strokeWidth: 1.5,
                                                        ),
                                                      )),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error,
                                                            size: w * 0.05),
                                              ),
                                              SizedBox(
                                                height: h * 0.01,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.all(w * 0.03),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: w * 0.6,
                                                      child: Text(
                                                        '${successState.orderDetailsResponse?.data?.products?[index].name}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style:
                                                            Styles.textStyle16(
                                                                    context)
                                                                .copyWith(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: w * 0.03,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.02,
                                                    ),
                                                    Text(
                                                      '${successState.orderDetailsResponse?.data?.products?[index].price}  EGP',
                                                      style: Styles.textStyle16(
                                                              context)
                                                          .copyWith(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.02,
                                                    ),
                                                    Text(
                                                      'Qty: ${successState.orderDetailsResponse?.data?.products?[index].quantity}',
                                                      style: Styles.textStyle16(
                                                              context)
                                                          .copyWith(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ]);
                        },
                      ),
                    ),
                  ),
                  InfoWidget(
                    builder: (context, deviceInfo) {
                      return Container(
                          width: w,
                          height: deviceInfo.deviceType == DeviceType.Desktop
                              ? h * 0.15
                              : h * 0.12,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.only(
                              left: w * 0.03,
                              right: w * 0.03,
                              bottom: w * 0.03),
                          //margin: const EdgeInsets.all(7),
                          child: Column(children: [
                            Row(
                              children: [
                                Text(
                                  'Total: ',
                                  style: Styles.textStyle20(context),
                                ),
                                const Spacer(),
                                Text(
                                  '${successState.orderDetailsResponse?.data?.total} EGP',
                                  style: Styles.textStyle20(context),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              height: h * 0.06,
                              width: w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: kSecondaryColor,
                                  width: 1,
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RoutesManager.cartRouteName);
                                },
                                child: Text(
                                  'Go To SoppingCart',
                                  style: Styles.textStyle20(context).copyWith(
                                    color: kSecondaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ]));
                    },
                  ),
                ],
              );
          }

          return Container();
        },
      ),
    );
  }
}
