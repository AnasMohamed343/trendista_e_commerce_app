import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/styles.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/presentation/ui/details_screen/product_details_screen.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_fav_icon_button.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_icon_button_addtocart.dart';

class CustomFavoriteItem extends StatelessWidget {
  final Product favProduct;
  //final Function(String)? onToggleFavorite;
  Widget? removeIcon;
  Widget? updateQuantityWidget;
  final Function(String)? onToggleCart;
  Widget? oldPriceWidget;
  CustomFavoriteItem({
    super.key,
    required this.favProduct,
    //this.onToggleFavorite,
    this.removeIcon,
    this.onToggleCart,
    this.updateQuantityWidget,
    this.oldPriceWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 1.17,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 150.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(width: 1.5, color: kBorderColor),
        ),
        child: Row(children: [
          InkWell(
            onTap: () {
              if (favProduct.id != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(
                      productId: favProduct.id ?? 0,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Product not found',
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.red,
                ));
              }
            },
            child: Container(
              height: 156.h,
              width: 140.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                image: DecorationImage(
                    image: NetworkImage(favProduct.image ?? ''),
                    fit: BoxFit.contain),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            // Wrap the Column with Expanded
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 170.w,
                        child: Text(favProduct.name ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Styles.textStyle18.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const Spacer(),
                      removeIcon ??
                          CustomFavoriteIconButton(
                            productId: favProduct.id.toString(),
                            // onToggleFavorite:
                            //     onToggleFavorite ?? (productId) {},
                            // onToggleFavorite: (productId) {
                            //   viewModel
                            //       .addOrRemoveFavorite(productId);
                            // },
                          ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(favProduct.description ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Styles.textStyle14),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text(
                        '\$ ${favProduct.price}',
                        style: Styles.textStyle15.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      oldPriceWidget = oldPriceWidget ??
                          Text(
                            '${favProduct.oldPrice} \$',
                            style: Styles.textStyle13,
                          ),
                      // updateQuantityWidget == null
                      //     ? const Spacer()
                      //     : const Spacer(),
                      const Spacer(),
                      updateQuantityWidget ??
                          CustomIconButtonAddToCart(
                            productId: favProduct.id.toString(),
                            onToggleCart: onToggleCart ?? (productId) {},
                          ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
