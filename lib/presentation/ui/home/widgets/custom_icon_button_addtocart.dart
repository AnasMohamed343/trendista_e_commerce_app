import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/ui_components/info_widget.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/carts/cart_vm.dart';

class CustomIconButtonAddToCart extends StatefulWidget {
  final String productId;
  final Function(String) onToggleCart;
  const CustomIconButtonAddToCart(
      {super.key, required this.productId, required this.onToggleCart});

  @override
  State<CustomIconButtonAddToCart> createState() =>
      _CustomIconButtonAddToCartState();
}

class _CustomIconButtonAddToCartState extends State<CustomIconButtonAddToCart> {
  late final CartVM viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = context.read<CartVM>();
  }

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        widget.onToggleCart(widget.productId);
        setState(() {});
      },
      child: InfoWidget(
        builder: (context, deviceInfo) {
          double w = deviceInfo.screenWidth;
          double h = deviceInfo.screenHeight;
          return Container(
            width: w * 0.08,
            height: h * 0.046,
            alignment: Alignment.center,
            padding: EdgeInsets.all(w * 0.01),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: kSecondaryColor,
            ),
            child: Icon(
              viewModel.isAddedToCart(widget.productId)
                  ? Icons.remove_shopping_cart_outlined
                  : Icons.add_shopping_cart,
              color: Colors.white,
              size: w * 0.047,
            ),
          );
        },
      ),
    );
  }
}
//
// child: BlocBuilder<CartVM, CartState>(
// bloc: viewModel,
// builder: (context, state) {
// // Check if the product is in the cart using the VM's method
// final isAdded = viewModel.isAddedToCart(widget.productId);
//
// return Icon(
// isAdded
// ? Icons.remove_shopping_cart_outlined
//     : Icons.add_shopping_cart,
// color: Colors.white,
// size: 22,
// );
// },
// ),
