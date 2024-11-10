import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/enums/device_type.dart';
import 'package:trendista_e_commerce/core/styles.dart';
import 'package:trendista_e_commerce/core/ui_components/info_widget.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/presentation/ui/product_details_screen/product_details_screen.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_fav_icon_button.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_icon_button_addtocart.dart';

class CustomFavoriteItem extends StatelessWidget {
  final Product favProduct;
  //final Function(String)? onToggleFavorite;
  Widget? removeIcon;
  Widget? updateQuantityWidget;
  final Function(String)? onToggleCart;
  Widget? oldPriceWidget;
  Widget? checkSquareWidget;
  CustomFavoriteItem({
    super.key,
    required this.favProduct,
    //this.onToggleFavorite,
    this.removeIcon,
    this.onToggleCart,
    this.updateQuantityWidget,
    this.oldPriceWidget,
    this.checkSquareWidget,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return InfoWidget(builder: (context, deviceInfo) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: w * 0.02),
        height: deviceInfo.deviceType == DeviceType.Desktop ||
                deviceInfo.deviceType == DeviceType.Tablet
            ? h * 0.21
            : deviceInfo.deviceType == DeviceType.TallMobile
                ? h * 0.15
                : h * 0.17,
        width: w * 0.9,
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
            child: Stack(
              children: [
                Container(
                  height: deviceInfo.localHeight,
                  width: deviceInfo.localWidth * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    image: DecorationImage(
                        image: NetworkImage(favProduct.image ?? ''),
                        fit: BoxFit.contain),
                  ),
                ),
                checkSquareWidget ?? const SizedBox(),
              ],
            ),
          ),
          SizedBox(width: w * 0.01),
          Expanded(
            // Wrap the Column with Expanded
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: w * 0.46,
                        child: Text(favProduct.name ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Styles.textStyle18(context).copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const Spacer(),
                      Expanded(
                        child: removeIcon ??
                            CustomFavoriteIconButton(
                              radius: w * 0.05,
                              width: w * 0.07,
                              height: h * 0.07,
                              productId: favProduct.id.toString(),
                              // onToggleFavorite:
                              //     onToggleFavorite ?? (productId) {},
                              // onToggleFavorite: (productId) {
                              //   viewModel
                              //       .addOrRemoveFavorite(productId);
                              // },
                            ),
                      ),
                    ],
                  ),
                  //SizedBox(height: h * 0.0002),
                  Text(favProduct.description ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Styles.textStyle14(context)),
                  SizedBox(height: h * 0.005),
                  Row(
                    children: [
                      Text(
                        '\$ ${favProduct.price}',
                        style: Styles.textStyle15(context).copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: w * 0.04),
                      oldPriceWidget = oldPriceWidget ??
                          Text(
                            '${favProduct.oldPrice} \$',
                            style: Styles.textStyle13(context),
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
      );
    });
  }
}
