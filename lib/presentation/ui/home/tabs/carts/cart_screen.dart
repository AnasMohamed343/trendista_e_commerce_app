import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/styles.dart';
import 'package:trendista_e_commerce/core/utils/assets_manager.dart';
import 'package:trendista_e_commerce/di/di.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/carts/cart_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/favorite_tab/custom_fav_item.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_app_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  //final viewModel = getIt<CartVM>();
  late final CartVM viewModel;
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.repeat(period: const Duration(seconds: 3));
    viewModel = context.read<CartVM>()..initPage();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(appbarTitle: 'Shopping Cart'),
      body: BlocBuilder<CartVM, CartState>(
          bloc: viewModel,
          builder: (context, state) {
            switch (state) {
              case CartLoadingState():
                {
                  return Center(
                    child: Lottie.network(
                      'https://lottie.host/0cce1419-944e-479e-9342-aabfea0689ab/FfEKIRAzvN.json',
                      width: 120,
                      height: 120,
                      repeat: true,
                      controller: _controller,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error_outline);
                      },
                    ),
                  );
                }
              case CartErrorState():
                {
                  print('${state.errorMessage}');
                  return Center(
                    child: Column(
                      children: [
                        Expanded(child: Text(state.errorMessage ?? '')),
                        ElevatedButton(
                          onPressed: () {
                            viewModel.initPage();
                          },
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  );
                }
              case CartSuccessState():
                {
                  if (state.cartItems == null || state.cartItems!.isEmpty) {
                    return const Center(child: Text('No items in the cart'));
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          addAutomaticKeepAlives: true,
                          itemCount: state.cartItems?.length,
                          cacheExtent: 500,
                          itemBuilder: (context, index) {
                            return CustomFavoriteItem(
                                favProduct: state.cartItems![index],
                                // onRemove: () {
                                //   viewModel.removeProductFromCart(
                                //       viewModel.cartProducts[index]);
                                // },
                                removeIcon: GestureDetector(
                                    onTap: () {
                                      viewModel.addOrRemoveCart(state
                                          .cartItems![index].id
                                          .toString());
                                    },
                                    child: SvgPicture.asset(
                                      AssetsManager.removeIcon,
                                      color: Colors.red.shade700,
                                    )),
                                oldPriceWidget: const SizedBox(
                                  width: 5,
                                ),
                                updateQuantityWidget: Container(
                                  height: ScreenUtil().setHeight(40),
                                  width: ScreenUtil().setWidth(130),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: kPrimaryColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          // Get the current quantity
                                          int currentQuantity =
                                              viewModel.getQuantity(state
                                                  .cartItems![index].id
                                                  .toString());

                                          if (currentQuantity > 1) {
                                            viewModel.updateCartQuantity(
                                                state.cartItems![index].id
                                                    .toString(), // Ensure id is String
                                                currentQuantity -
                                                    1); // Pass int for quantity
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.remove_circle_outline,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        viewModel
                                            .getQuantity(state
                                                .cartItems![index].id
                                                .toString())
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          int currentQuantity =
                                              viewModel.getQuantity(state
                                                  .cartItems![index].id
                                                  .toString());

                                          viewModel.updateCartQuantity(
                                              state.cartItems![index].id
                                                  .toString(),
                                              currentQuantity + 1);
                                        },
                                        icon: const Icon(
                                          Icons.add_circle_outline_outlined,
                                          size: 18,
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
                        height: 140.h,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Price',
                                    style: Styles.textStyle16.copyWith(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'EGP ${state.totalPrice}',
                                    style: Styles.textStyle16.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: kPrimaryColor,
                                      shape: const StadiumBorder(),
                                      foregroundColor: Colors.white,
                                      minimumSize: const Size(150, 50),
                                      textStyle: Styles.textStyle18),
                                  onPressed: () {},
                                  child: const Text(
                                      '      Check Out           >>'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
            }
          }),
    );
  }
}
