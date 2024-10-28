import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/styles.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/presentation/ui/details_screen/product_details_screen.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/carts/cart_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/favorite_tab/favorite_tab_vm.dart';
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
  late final CartVM cartViewModel;

  @override
  void initState() {
    super.initState();
    //favViewModel = context.read<FavoriteTabVM>()..initPage();

    cartViewModel = context.read<CartVM>()..initPage();
  }

  @override
  Widget build(BuildContext context) {
    // print('Type of price: ${widget.product.price.runtimeType}');
    // print('Type of price: ${widget.product.oldPrice.runtimeType}');
    //final favoriteProvider = Provider.of<FavoriteProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      width: ScreenUtil().setWidth(207),
      height: ScreenUtil().setHeight(500),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(width: 1.5, color: kBorderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Product not found',
                          style: Styles.textStyle18.copyWith(
                            color: Colors.white,
                          )),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: CachedNetworkImage(
                  imageBuilder: (context, imageProvider) => Container(
                    width: ScreenUtil().setWidth(207),
                    height: ScreenUtil().setHeight(155),
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
                        width: 195.w,
                        height: 155.h,
                        color: Colors.white,
                        child: const CircularProgressIndicator(
                          strokeWidth: 1.5,
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
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, right: 7, left: 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.product.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.textStyle16.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  widget.product.description ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.textStyle15,
                ),
                SizedBox(
                  height: 10.h,
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
                      style: Styles.textStyle15,
                    ),
                    SizedBox(
                      width: 14.w,
                    ),
                    Visibility(
                      visible: widget.product.discount != 0,
                      child: Text(
                        '${widget.product.oldPrice.toString()} \$',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.textStyle13,
                      ),
                    ),
                    const Spacer(),
                    CustomIconButtonAddToCart(
                      productId: widget.product.id.toString(),
                      onToggleCart: (productId) {
                        cartViewModel.addOrRemoveCart(productId);
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
  }
}
