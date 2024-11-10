import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:trendista_e_commerce/core/styles.dart';
import 'package:trendista_e_commerce/core/utils/assets_manager.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/presentation/ui/product_details_screen/product_details_screen.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/carts/cart_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/favorite_tab/custom_fav_item.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_fav_icon_button.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_icon_button_addtocart.dart';
import 'package:trendista_e_commerce/providers/favorite_provider.dart';

class FavoriteListTab extends StatefulWidget {
  @override
  State<FavoriteListTab> createState() => _FavoriteListTabState();
}

class _FavoriteListTabState extends State<FavoriteListTab>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.repeat(period: const Duration(seconds: 3));
    Future.microtask(() =>
        Provider.of<FavoriteProvider>(context, listen: false).fetchFavorites());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<FavoriteProvider>(
        builder: (context, favoriteProvider, child) {
          if (favoriteProvider.isAddingFavorite) {
            return Center(
              child: Lottie.network(
                'https://lottie.host/0f1086d9-3279-43d0-af72-7e54dfb1fb05/HjcfZ57lor.json',
                repeat: true,
                backgroundLoading: true,
                width: w * 0.6,
                height: h * 0.6,
                frameRate: const FrameRate(60),
                controller: _controller,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error_outline);
                },
                animate: true,
              ),
            );
          } else if (favoriteProvider.favoriteProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetsManager.noFavoritesYet,
                    height: h * 0.7,
                    width: w * 0.7,
                  ),
                  SizedBox(height: h * 0.02),
                  Text('No favorites yet', style: Styles.textStyle20(context)),
                ],
              ),
            );
          } else {
            return ListView.builder(
              cacheExtent: 500,
              addAutomaticKeepAlives: true,
              itemCount: favoriteProvider.favoriteProducts.length,
              itemBuilder: (context, index) {
                final favProduct = favoriteProvider.favoriteProducts[index];
                return CustomFavoriteItem(
                  favProduct: favProduct,
                  // // Pass a callback to update favorites in the provider
                  // onToggleFavorite: (productId) {
                  //   favoriteProvider.addOrRemoveFavorite(productId);
                  // },
                  onToggleCart: (productId) {
                    final cartVM = context.read<CartVM>();
                    cartVM.addOrRemoveCart(productId);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
