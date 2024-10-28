import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/styles.dart';
import 'package:trendista_e_commerce/di/di.dart';
import 'package:trendista_e_commerce/presentation/ui/details_screen/product_details_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/carts/cart_vm.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/favorite_tab/favorite_tab_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_fav_icon_button.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_page_indicator.dart';
import 'package:trendista_e_commerce/providers/favorite_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with TickerProviderStateMixin {
  bool showFullDescription = false;
  late final AnimationController _controller;
  final pageController = PageController();

  late final ProductDetailsVM detailsViewModel;
  late final CartVM cartViewModel;
  //late final FavoriteTabVM favViewModel;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.repeat(period: const Duration(seconds: 3));
    detailsViewModel = context.read<ProductDetailsVM>()
      ..initPage(widget.productId);
    cartViewModel = context.read<CartVM>();
    //favViewModel = context.read<FavoriteTabVM>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final detailsViewModel = context.read<ProductDetailsVM>()
    //   ..initPage(widget.productId);
    // final cartViewModel = context.read<CartVM>();
    //final favoriteProvider = Provider.of<FavoriteProvider>(context);
    print('Product ID: ${widget.productId}');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Product Details'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: CustomFavoriteIconButton(
              productId: widget.productId.toString(), // Pass product ID
              // onToggleFavorite: (productId) {
              //   setState(() {
              //     favViewModel.addOrRemoveFavorite(productId);
              //   });
              // },
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProductDetailsVM, ProductDetailsState>(
        builder: (context, state) {
          print('Current State: $state');
          if (state is LoadingState) {
            return Center(
              child: Lottie.network(
                  'https://lottie.host/f45c9991-322a-4fe7-bf28-1b08fcb62e6c/xBEyXbOlwu.json',
                  width: 240,
                  height: 240,
                  repeat: true, errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error_outline);
              }, controller: _controller),
              //const SizedBox(width: 8),
              //Text(state.message),
            );
          } else if (state is ErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage ?? 'An error occurred'),
                  ElevatedButton(
                    onPressed: () {
                      detailsViewModel.initPage(widget.productId);
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          } else if (state is SuccessState) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: ScreenUtil().setHeight(360),
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            PageView.builder(
                              itemCount:
                                  state.productDetails?.images?.length ?? 0,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              controller: pageController,
                              itemBuilder: (context, index) {
                                return Image.network(
                                  state.productDetails?.images?[index] ?? '',
                                  fit: BoxFit.contain,
                                );
                              },
                            ),
                            Positioned(
                              bottom: 7,
                              child: CustomPageIndicator(
                                dotHeight: 5,
                                dotWidth: 5,
                                controller: pageController,
                                count:
                                    state.productDetails?.images?.length ?? 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: ScreenUtil().setWidth(250),
                                  child: Text(
                                    state.productDetails?.name ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Styles.textStyle20.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'EGP ${state.productDetails?.price}',
                                  style: Styles.textStyle18.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Discount: ',
                                      style: Styles.textStyle16.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '${state.productDetails?.discount} % off',
                                      style: Styles.textStyle16.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  height: ScreenUtil().setHeight(45),
                                  width: ScreenUtil().setWidth(150),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: kPrimaryColor,
                                  ),
                                  // child: Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     IconButton(
                                  //       onPressed: () {
                                  //         int currentQuantity =
                                  //             cartViewModel.getQuantity(state
                                  //                     .productDetails?.id
                                  //                     .toString() ??
                                  //                 '');
                                  //         if (currentQuantity > 1) {
                                  //           cartViewModel.updateCartQuantity(
                                  //               state.productDetails?.id
                                  //                       .toString() ??
                                  //                   '',
                                  //               currentQuantity - 1);
                                  //           detailsViewModel.updateQuantity(
                                  //               currentQuantity -
                                  //                   1); // Update in ProductDetailsVM
                                  //         }
                                  //       },
                                  //       icon: const Icon(Icons.remove,
                                  //           size: 15, color: Colors.white),
                                  //     ),
                                  //     Text(
                                  //       cartViewModel
                                  //           .getQuantity(state
                                  //                   .productDetails?.id
                                  //                   .toString() ??
                                  //               '')
                                  //           .toString(),
                                  //       style: const TextStyle(
                                  //           color: Colors.white),
                                  //     ),
                                  //     IconButton(
                                  //       onPressed: () {
                                  //         int currentQuantity =
                                  //             cartViewModel.getQuantity(state
                                  //                     .productDetails?.id
                                  //                     .toString() ??
                                  //                 '');
                                  //         cartViewModel.updateCartQuantity(
                                  //             state.productDetails?.id
                                  //                     .toString() ??
                                  //                 '',
                                  //             currentQuantity + 1);
                                  //         detailsViewModel.updateQuantity(
                                  //             currentQuantity +
                                  //                 1); // Update in ProductDetailsVM
                                  //       },
                                  //       icon: const Icon(Icons.add,
                                  //           size: 15, color: Colors.white),
                                  //     ),
                                  //   ],
                                  // ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          int currentQuantity = detailsViewModel
                                                      .productQuantities[
                                                  widget.productId] ??
                                              1;
                                          if (currentQuantity > 1) {
                                            detailsViewModel.updateQuantity(
                                                widget.productId,
                                                currentQuantity - 1);
                                          }
                                        },
                                        icon: const Icon(
                                            Icons.remove_circle_outline,
                                            size: 22,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        detailsViewModel.productQuantities[
                                                    widget.productId]
                                                ?.toString() ??
                                            '1',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          int currentQuantity = detailsViewModel
                                                      .productQuantities[
                                                  widget.productId] ??
                                              1;
                                          detailsViewModel.updateQuantity(
                                              widget.productId,
                                              currentQuantity + 1);
                                        },
                                        icon: const Icon(
                                            Icons.add_circle_outline_outlined,
                                            size: 22,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Description',
                              style: Styles.textStyle18.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              state.productDetails?.description ?? '',
                              maxLines: showFullDescription ? null : 6,
                              overflow: showFullDescription
                                  ? null
                                  : TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                              softWrap: true,
                              textDirection: TextDirection.ltr,
                              textScaleFactor: 1.0,
                              textWidthBasis: TextWidthBasis.parent,
                              style: Styles.textStyle16.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            if (state.productDetails?.description != null &&
                                state.productDetails!.description!.length > 150)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showFullDescription = !showFullDescription;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    showFullDescription
                                        ? 'Read Less'
                                        : '..Read More',
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ),
                            SizedBox(height: 115.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: ScreenUtil().setHeight(110),
                    color: Colors.white,
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
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'EGP ${state.totalPrice}', //'EGP ${state.productDetails?.price ?? 0 * cartViewModel.getQuantity(state.productDetails?.id.toString() ?? '')}',
                                style: Styles.textStyle16.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                String productId =
                                    state.productDetails?.id.toString() ?? '';
                                int selectedQuantity =
                                    detailsViewModel.productQuantities[
                                            state.productDetails?.id] ??
                                        1;

                                // Only add or update cart when "Add To Cart" is pressed
                                if (cartViewModel.isAddedToCart(productId)) {
                                  // Product is already in the cart, update its quantity
                                  cartViewModel.updateCartQuantity(
                                      productId, selectedQuantity);
                                  detailsViewModel.clearQuantity(
                                      state.productDetails?.id ?? 0);
                                  Fluttertoast.showToast(
                                    msg: 'Cart Quantity Updated',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                } else {
                                  // Product is not in the cart, add it with the selected quantity
                                  cartViewModel.addOrRemoveCart(productId);
                                  cartViewModel.updateCartQuantity(
                                      productId, selectedQuantity);
                                  detailsViewModel.clearQuantity(
                                      state.productDetails?.id ?? 0);
                                  Fluttertoast.showToast(
                                    msg: 'Added to Cart',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                }
                              },
                              child: Container(
                                height: 60.h,
                                width: 120.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: kPrimaryColor,
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_shopping_cart_outlined,
                                        color: Colors.white, size: 20),
                                    SizedBox(width: 20),
                                    Text('Add To Cart',
                                        style: Styles.textStyle16),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

// ListView.builder(
// itemCount: state.productDetails?.images?.length,
// shrinkWrap: true,
// scrollDirection: Axis.horizontal,
// itemBuilder: (BuildContext context, int index) {
// return Container(
// //margin: const EdgeInsets.symmetric(horizontal: 10),
// height: ScreenUtil().setHeight(350),
// width: double.infinity,
// decoration: BoxDecoration(
// borderRadius: const BorderRadius.only(
// bottomLeft: Radius.circular(30),
// bottomRight: Radius.circular(30)),
// image: DecorationImage(
// fit: BoxFit.contain,
// onError: (state, error) => Container(
// color: Colors.grey,
// child: const Text('image not found'),
// ),
// image: NetworkImage(
// state.productDetails?.images?[index] ??
// 'https://via.placeholder.com/150',
// )),
// ),
// );
// },
// ),
