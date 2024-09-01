import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';

class ProductItemWidget extends StatelessWidget {
  Product product;
  ProductItemWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      width: 191.w,
      height: 237.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(width: 1.5, color: Color(0x6E004182))),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment(0.96, -0.9),
              //alignment: Alignment.topRight,
              children: [
                CachedNetworkImage(
                  imageBuilder: (context, imageProvider) => Container(
                    width: 191.w,
                    height: 128.h,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: imageProvider)),
                  ),
                  imageUrl: product.imageCover ?? '',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/icons/ic_fav.png',
                    width: 20.w,
                    height: 19.h,
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 4, bottom: 5, right: 5, left: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    product.description ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Row(
                    children: [
                      Visibility(
                          visible: product.priceAfterDiscount !=
                              null, // if priceAfterDiscount != null => make it visible , else don't show it
                          child: Text(
                            'EGP ${product.priceAfterDiscount.toString()}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          )),
                      SizedBox(
                        width: product.priceAfterDiscount != null ? 11.w : 0,
                      ),
                      Text(
                        '${product.price.toString()} EGP' ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            decorationColor: Colors.blue,
                            fontSize:
                                product.priceAfterDiscount != null ? 13 : 14,
                            color: product.priceAfterDiscount != null
                                ? Colors.blue
                                : Colors.black,
                            decoration: product.priceAfterDiscount != null
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'Review (${product.ratingsAverage})',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      Icon(
                        Icons.star,
                        color: Color(0xffF4B400),
                        size: 20,
                      ),
                      Spacer(),
                      Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.blue.shade900,
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            weight: 40,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
