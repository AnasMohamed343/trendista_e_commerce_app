import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/styles.dart';
import 'package:trendista_e_commerce/core/utils/assets_manager.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:trendista_e_commerce/di/di.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/carts/cart_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/favorite_tab/custom_fav_item.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/profile_tab/edit_profile.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/profile_tab/orders_screen/orders_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_app_bar.dart';
import 'package:trendista_e_commerce/services/paymob_manager/paymob_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../domain/entities/Product.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  //final viewModel = getIt<CartVM>();
  //late final CartVM viewModel;
  late final AnimationController _controller;
  final orderVM = getIt<OrdersViewModel>();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.repeat(period: const Duration(seconds: 3));
    //viewModel = context.read<CartVM>()..initPage();
    _controller.repeat(period: const Duration(seconds: 3));
    // Call initPage after the widget is fully initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartVM>(context, listen: false).initPage();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartVM>(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(appbarTitle: 'Shopping Cart'),
        body: Consumer<CartVM>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return Center(
                child: Lottie.network(
                  'https://lottie.host/0cce1419-944e-479e-9342-aabfea0689ab/FfEKIRAzvN.json',
                  width: w * 0.3,
                  height: h * 0.3,
                  repeat: true,
                  controller: _controller,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error_outline);
                  },
                ),
              );
            } else if (value.cartItems?.isEmpty ?? true) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetsManager.emptyCart,
                      width: w * 0.3,
                      height: h * 0.3,
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    Text(
                      'Your cart is empty',
                      style: Styles.textStyle20(context),
                    )
                  ],
                ),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      addAutomaticKeepAlives: true,
                      itemCount: value.cartItems!.length,
                      cacheExtent: 500,
                      itemBuilder: (context, index) {
                        final cartItem = value.cartItems![index];
                        return CustomFavoriteItem(
                            favProduct: cartItem.product ?? Product(),
                            // onRemove: () {
                            //   viewModel.removeProductFromCart(
                            //       viewModel.cartProducts[index]);
                            // },
                            removeIcon: GestureDetector(
                                onTap: () {
                                  cartProvider.addOrRemoveCart(
                                      (cartItem.product!.id).toString());
                                  setState(() {});
                                },
                                child: SvgPicture.asset(
                                  AssetsManager.removeIcon,
                                  color: Colors.red.shade700,
                                  height: h * 0.050,
                                  width: w * 0.06,
                                )),
                            oldPriceWidget: SizedBox(
                              width: w * 0.03,
                            ),
                            updateQuantityWidget: Container(
                              height: h * 0.05,
                              width: w * 0.30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: kPrimaryColor,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      int? quantity = cartItem.quantity;
                                      // viewModel.updateCartQuantity(
                                      //   cartItem.id!
                                      //       .toInt(), // Pass product ID as int
                                      //   (quantity! - 1)
                                      //       .toString(), // Pass quantity as int
                                      // );
                                      if (quantity! > 1) {
                                        // Ensure quantity doesn’t go below 1
                                        cartProvider.updateCartQuantity(
                                            cartItem.id!,
                                            (quantity - 1).toString());
                                      }
                                      // setState(() {
                                      //   // Update UI
                                      //   cartItem.quantity = quantity - 1;
                                      // });
                                    },
                                    icon: Icon(
                                      Icons.remove_circle_outline,
                                      size: w * 0.040,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${cartItem.quantity}',
                                    style: Styles.textStyle18(context)
                                        .copyWith(color: Colors.white),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      int? quantity = cartItem.quantity;
                                      cartProvider.updateCartQuantity(
                                        cartItem.id!
                                            .toInt(), // Pass product ID as int
                                        (quantity! + 1)
                                            .toString(), // Pass quantity as int
                                      );
                                      // viewModel.updateCartQuantity(
                                      //     cartItem.id!,
                                      //     (quantity! + 1).toString());
                                      // setState(() {
                                      //   // Update UI
                                      //   cartItem.quantity = quantity + 1;
                                      // });
                                    },
                                    icon: Icon(
                                      Icons.add_circle_outline_outlined,
                                      size: w * 0.040,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              // onToggleCart: (productId) {
                              //   viewModel.addOrRemoveCart(productId);
                              // },
                            ));
                      },
                    ),
                  ),
                  SizedBox(
                    height: h * 0.12,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsetsDirectional.all(w * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Total Price',
                                style: Styles.textStyle18(context).copyWith(
                                  color: Colors.black54,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'EGP ${cartProvider.totalPrice}',
                                style: Styles.textStyle18(context).copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   height: h * 0.014,
                          // ),
                          const Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                shape: const StadiumBorder(),
                                foregroundColor: Colors.white,
                                minimumSize: Size(double.infinity, h * 0.05),
                                textStyle: Styles.textStyle18(context)),
                            onPressed: () {
                              //show modalbottomsheet for handling the checkout process that will done by using paymob api
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                builder: (context) {
                                  return Container(
                                    padding:
                                        EdgeInsetsDirectional.all(w * 0.02),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '         Add To Orders          ',
                                          style: Styles.textStyle20(context)
                                              .copyWith(color: kPrimaryColor),
                                        ),
                                        SizedBox(
                                          height: h * 0.02,
                                        ),
                                        CustomButton(
                                          buttonSize: Size(w * 0.5, w * 0.07),
                                          icon: Icons.shopping_bag,
                                          buttonColor: kPrimaryColor,
                                          buttonTextColor: Colors.white,
                                          buttonText: 'Add Order',
                                          onTap: () async {
                                            //_pay();
                                            // try {
                                            //   await orderVM.addOrder().then(
                                            //       (_) =>
                                            //           Navigator.pop(context));
                                            //   _showPaymentBottomSheet(context);
                                            //   //Navigator.pop(context);
                                            // } catch (e) {
                                            //   print('Error: $e');
                                            // }
                                            try {
                                              // Show a loading indicator
                                              showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (context) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              );

                                              // Add the order
                                              await orderVM.addOrder();
                                              // Hide the loading indicator
                                              Navigator.of(context).pop();
                                              Fluttertoast.showToast(
                                                msg: 'Order Added Successfully',
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                fontSize: w * 0.02,
                                              );
                                              // Hide the add order button
                                              Navigator.of(context).pop();
                                              //refresh cart

                                              // Show the payment bottom sheet
                                              _showPaymentBottomSheet(context);
                                              //refresh cart
                                              await cartProvider.refreshCart();
                                            } catch (e) {
                                              // Hide the loading indicator
                                              Navigator.of(context).pop();

                                              // Handle the error
                                              print('Error: $e');
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              '    Check Out      >>',
                              style: Styles.textStyle18(context)
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }

  Future<void> _pay() async {
    final cartProvider = Provider.of<CartVM>(context, listen: false);
    double w = MediaQuery.of(context).size.width;
    if (cartProvider.cartItems!.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Cart is empty',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: w * 0.04);
      return;
    }
    PayMobManager().getPaymentKey(cartProvider.totalPrice ?? 0, 'EGP').then(
        (String paymentKey) => launchUrl(Uri.parse(
            "https://accept.paymob.com/api/acceptance/iframes/878257?payment_token=$paymentKey")));
  }

  void _showPaymentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (context) {
        double w = MediaQuery.of(context).size.width;
        return Container(
          padding: EdgeInsetsDirectional.all(w * 0.02),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pay with cash on delivery',
                style:
                    Styles.textStyle20(context).copyWith(color: kPrimaryColor),
              ),
              SizedBox(
                height: w * 0.02,
              ),
              CustomButton(
                buttonSize: Size(w * 0.5, w * 0.07),
                icon: FeatherIcons.dollarSign,
                buttonColor: kPrimaryColor,
                buttonTextColor: Colors.white,
                buttonText: 'Pay Now',
                onTap: () {
                  _pay();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
