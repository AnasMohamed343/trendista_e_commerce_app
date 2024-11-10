import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/styles.dart';
import 'package:trendista_e_commerce/di/di.dart';
import 'package:trendista_e_commerce/domain/entities/cartitem_entity.dart';
import 'package:trendista_e_commerce/presentation/ui/product_details_screen/product_details_vm.dart';
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
  //late final CartVM cartViewModel;
  //late final FavoriteTabVM favViewModel;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.repeat(period: const Duration(seconds: 3));
    detailsViewModel = context.read<ProductDetailsVM>()
      ..initPage(widget.productId);
    //cartViewModel = context.read<CartVM>();
    //favViewModel = context.read<FavoriteTabVM>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    // final detailsViewModel = context.read<ProductDetailsVM>()
    //   ..initPage(widget.productId);
    // final cartViewModel = context.read<CartVM>();
    //final favoriteProvider = Provider.of<FavoriteProvider>(context);
    print('Product ID: ${widget.productId}');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Product Details',
          style: Styles.textStyle20(context).copyWith(
            color: kSecondaryColor,
            fontSize: w * 0.050,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.03),
            child: CustomFavoriteIconButton(
              radius: w * 0.05,
              width: w * 0.08,
              height: w * 0.08,
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
          final cartProvider = Provider.of<CartVM>(context);
          print('Current State: $state');
          if (state is LoadingState) {
            return Center(
              child: Lottie.network(
                  'https://lottie.host/f45c9991-322a-4fe7-bf28-1b08fcb62e6c/xBEyXbOlwu.json',
                  width: w * 0.4,
                  height: h * 0.4,
                  repeat: true, errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.error_outline,
                  size: w * 0.4,
                );
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
                    child: Text(
                      'Try Again',
                      style: Styles.textStyle20(context),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is SuccessState) {
            final cartItem = cartProvider.cartItems != null &&
                    cartProvider.cartItems!.isNotEmpty
                ? cartProvider.cartItems!.firstWhere(
                    (item) => item.product?.id == widget.productId,
                    orElse: () => CartItemEntity(
                        product: null,
                        quantity:
                            0), // Return a default CartItemEntity if not found
                  )
                : CartItemEntity(product: null, quantity: 0);
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: h * 0.4,
                        width: w,
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
                                  fit: BoxFit.fill,
                                );
                              },
                            ),
                            Positioned(
                              bottom: h * 0.01,
                              child: CustomPageIndicator(
                                dotHeight: h * 0.01,
                                dotWidth: w * 0.02,
                                controller: pageController,
                                count:
                                    state.productDetails?.images?.length ?? 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: h * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: w * 0.6,
                                  child: Text(
                                    state.productDetails?.name ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Styles.textStyle20(context).copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'EGP ${state.productDetails?.price}',
                                  style: Styles.textStyle18(context).copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: h * 0.01),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Discount: ',
                                      style:
                                          Styles.textStyle16(context).copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '${state.productDetails?.discount} % off',
                                      style:
                                          Styles.textStyle16(context).copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  height: h * 0.05,
                                  width: w * 0.3,
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
                                          int? quantity = cartItem.quantity;
                                          // int currentQuantity = detailsViewModel
                                          //             .productQuantities[
                                          //         widget.productId] ??
                                          //     1;
                                          if (quantity! > 1) {
                                            cartProvider.updateCartQuantity(
                                                cartItem.id ?? 0,
                                                (quantity - 1).toString());
                                          }
                                        },
                                        icon: Icon(Icons.remove_circle_outline,
                                            size: w * 0.05,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        // detailsViewModel.productQuantities[
                                        //             widget.productId]
                                        //         ?.toString() ??
                                        //     '1',
                                        '${cartItem.quantity}',
                                        style: Styles.textStyle18(context)
                                            .copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          int? quantity = cartItem.quantity;
                                          // int currentQuantity = detailsViewModel
                                          //             .productQuantities[
                                          //         widget.productId] ??
                                          //     1;
                                          cartProvider.updateCartQuantity(
                                              cartItem.id ?? 0,
                                              (quantity! + 1).toString());
                                        },
                                        icon: Icon(
                                            Icons.add_circle_outline_outlined,
                                            size: w * 0.05,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: h * 0.01),
                            Text(
                              'Description',
                              style: Styles.textStyle18(context).copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: h * 0.01),
                            GestureDetector(
                              onDoubleTap: () {
                                setState(() {
                                  showFullDescription = !showFullDescription;
                                });
                              },
                              child: Text(
                                state.productDetails?.description ?? '',
                                maxLines: showFullDescription ? null : 7,
                                overflow: showFullDescription
                                    ? null
                                    : TextOverflow.ellipsis,
                                textAlign: TextAlign.justify,
                                softWrap: true,
                                textDirection: TextDirection.ltr,
                                textScaleFactor: 1.0,
                                textWidthBasis: TextWidthBasis.parent,
                                style: Styles.textStyle16(context).copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
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
                                  padding: EdgeInsets.only(top: h * 0.01),
                                  child: Text(
                                    showFullDescription
                                        ? 'Read Less'
                                        : '..Read More',
                                    style: Styles.textStyle18(context)
                                        .copyWith(color: Colors.blue),
                                  ),
                                ),
                              ),
                            SizedBox(height: h * 0.1),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: h * 0.1,
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
                                style: Styles.textStyle16(context).copyWith(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: h * 0.005,
                              ),
                              Text(
                                'EGP ${detailsViewModel.calculateTotalPrice(cartItem.product?.id ?? 0, cartItem?.quantity ?? 0)}', //'EGP ${state.productDetails?.price ?? 0 * cartViewModel.getQuantity(state.productDetails?.id.toString() ?? '')}',
                                style: Styles.textStyle16(context).copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: w * 0.05,
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
                                if (cartProvider.isAddedToCart(productId)) {
                                  // Product is already in the cart, update its quantity
                                  cartProvider.updateCartQuantity(
                                      int.parse(productId),
                                      selectedQuantity.toString());
                                  // detailsViewModel.clearQuantity(
                                  //     state.productDetails?.id ?? 0);
                                  Fluttertoast.showToast(
                                    msg: 'Cart Quantity Updated',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: w * 0.02,
                                  );
                                } else {
                                  // Product is not in the cart, add it with the selected quantity
                                  cartProvider.addOrRemoveCart(productId);
                                  cartProvider.updateCartQuantity(
                                      int.parse(productId),
                                      selectedQuantity.toString());
                                  // detailsViewModel.clearQuantity(
                                  //     state.productDetails?.id ?? 0);
                                  Fluttertoast.showToast(
                                    msg: 'Added to Cart',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: w * 0.02,
                                  );
                                }
                              },
                              child: Container(
                                height: h * 0.05,
                                width: w * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: kPrimaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_shopping_cart_outlined,
                                        color: Colors.white, size: w * 0.04),
                                    SizedBox(width: w * 0.02),
                                    Text('Add To Cart',
                                        style: Styles.textStyle16(context)),
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
