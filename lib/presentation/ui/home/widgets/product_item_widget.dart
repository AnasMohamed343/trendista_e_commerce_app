import 'package:cached_network_image/cached_network_image.dart';
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/core/enums/device_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/styles.dart';
import 'package:trendista_e_commerce/core/ui_components/info_widget.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/presentation/ui/product_details_screen/product_details_screen.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/carts/cart_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_fav_icon_button.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_icon_button_addtocart.dart';
import 'package:trendista_e_commerce/providers/favorite_provider.dart';

class ProductItemWidget extends StatefulWidget {
  final Product product;
  ProductItemWidget({
    required this.product,
    super.key,
  });

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  //late final FavoriteTabVM favViewModel;
  //late final CartVM cartViewModel;

  @override
  void initState() {
    super.initState();
    //favViewModel = context.read<FavoriteTabVM>()..initPage();

    //cartViewModel = context.read<CartVM>()..initPage();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartVM>(context, listen: false).initPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('Type of price: ${widget.product.price.runtimeType}');
    // print('Type of price: ${widget.product.oldPrice.runtimeType}');
    //final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final cartProvider = Provider.of<CartVM>(context);
    return InfoWidget(
      builder: (context, deviceInfo) {
        print('device type: ${deviceInfo.deviceType}');
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
            vertical: screenHeight * 0.01,
          ),
          // width: ScreenUtil().setWidth(207),
          // height: ScreenUtil().setHeight(500),
          width: deviceInfo.deviceType == DeviceType.Desktop
              ? deviceInfo.screenWidth / 2.3
              : deviceInfo.screenWidth / 2, //screenWidth / 2,
          height: deviceInfo.deviceType == DeviceType.Desktop
              ? deviceInfo.screenHeight / 3
              : deviceInfo.screenHeight / 3.1, //screenHeight * 0.3,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(width: 1.5, color: kBorderColor)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: const Alignment(0.9, -0.9),
                //alignment: Alignment.topRight,
                children: [
                  InkWell(
                    onTap: () {
                      if (widget.product.id != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                              productId: widget.product.id ?? 0,
                              // //pass favorite status from product details screen
                            ),
                          ),
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: 'No product found',
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          fontSize: 16.0,
                        );
                      }
                    },
                    child: CachedNetworkImage(
                      imageBuilder: (context, imageProvider) => Container(
                        // width: ScreenUtil().setWidth(210),
                        // height: ScreenUtil().setHeight(155),
                        width: deviceInfo.localWidth / 1,
                        height: deviceInfo.deviceType == DeviceType.TallMobile
                            ? deviceInfo.localHeight / 2
                            : deviceInfo.localHeight / 2.12,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(22),
                                topLeft: Radius.circular(22)),
                            image: DecorationImage(image: imageProvider)),
                      ),
                      imageUrl: widget.product.image ?? '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: Container(
                            // width: 195.w,
                            // height: 155.h,
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  EdgeInsets.all(deviceInfo.localHeight / 6.5),
                              child: const CircularProgressIndicator(
                                strokeWidth: 1.5,
                              ),
                            )),
                      ),
                    ),
                  ),
                  // CustomFavoriteIconButton(
                  //   productId: widget.product.id.toString(), // Pass product ID
                  //   // onToggleFavorite: (productId) {
                  //   //   favViewModel.addOrRemoveFavorite(productId);
                  //   // },
                  // ),
                  Consumer<FavoriteProvider>(
                    // Use Consumer for optimization
                    builder: (context, favoriteProvider, _) {
                      return CustomFavoriteIconButton(
                        productId: widget.product.id.toString(),
                      );
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight / 90,
                    bottom: screenHeight / 90,
                    right: screenWidth / 50,
                    left: screenWidth / 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.product.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.textStyle16(context).copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text(
                      widget.product.description ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.textStyle15(context),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    // Row(
                    //   children: [
                    //     Visibility(
                    //         visible: product.priceAfterDiscount !=
                    //             null, // if priceAfterDiscount != null => make it visible , else don't show it
                    //         child: Text(
                    //           'EGP ${product.priceAfterDiscount.toString()}',
                    //           maxLines: 1,
                    //           overflow: TextOverflow.ellipsis,
                    //           style: const TextStyle(
                    //               fontSize: 14, color: Colors.black),
                    //         )),
                    //     SizedBox(
                    //       width: product.priceAfterDiscount != null ? 11.w : 0,
                    //     ),
                    //     Text(
                    //       '${product.price.toString()} EGP' ?? '',
                    //       maxLines: 1,
                    //       overflow: TextOverflow.ellipsis,
                    //       style: TextStyle(
                    //           decorationColor: Colors.blue,
                    //           fontSize:
                    //               product.priceAfterDiscount != null ? 13 : 14,
                    //           color: product.priceAfterDiscount != null
                    //               ? Colors.blue
                    //               : Colors.black,
                    //           decoration: product.priceAfterDiscount != null
                    //               ? TextDecoration.lineThrough
                    //               : TextDecoration.none),
                    //     ),
                    //   ],
                    // ),
                    Row(
                      children: [
                        Text(
                          '\$ ${widget.product.price.toString()}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Styles.textStyle15(context),
                        ),
                        SizedBox(
                          width: screenWidth * 0.07,
                        ),
                        Visibility(
                          visible: widget.product.discount != 0,
                          child: Text(
                            '${widget.product.oldPrice.toString()} \$',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Styles.textStyle13(context),
                          ),
                        ),
                        const Spacer(),
                        CustomIconButtonAddToCart(
                          productId: widget.product.id.toString(),
                          onToggleCart: (productId) {
                            //cartViewModel.addOrRemoveCart(productId);
                            cartProvider.addOrRemoveCart(productId);
                          },
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       'Review (${product.ratingsAverage})',
                    //       style:
                    //           const TextStyle(color: Colors.black, fontSize: 14),
                    //     ),
                    //     const Icon(
                    //       Icons.star,
                    //       color: Color(0xffF4B400),
                    //       size: 20,
                    //     ),
                    //     const Spacer(),
                    //     Container(
                    //         padding: const EdgeInsets.all(3),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(40),
                    //           color: Colors.blue.shade900,
                    //         ),
                    //         child: const Icon(
                    //           Icons.add,
                    //           color: Colors.white,
                    //           weight: 40,
                    //         ))
                    //   ],
                    // )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
