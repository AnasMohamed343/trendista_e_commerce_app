// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:trendista_e_commerce/core/utils/assets_manager.dart';
// import 'package:trendista_e_commerce/di/di.dart';
// import 'package:trendista_e_commerce/domain/entities/Product.dart';
// import 'package:trendista_e_commerce/presentation/ui/home/tabs/favorite_tab/favorite_tab_vm.dart';
//
// class CustomFavoriteIconButton extends StatefulWidget {
//   final String productId;
//   final Function(String) onToggleFavorite;
//   CustomFavoriteIconButton({
//     super.key,
//     required this.productId,
//     required this.onToggleFavorite,
//   });
//
//   @override
//   State<CustomFavoriteIconButton> createState() =>
//       _CustomFavoriteIconButtonState();
// }
//
// class _CustomFavoriteIconButtonState extends State<CustomFavoriteIconButton> {
//   late final FavoriteTabVM viewModel;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     viewModel = context.read<FavoriteTabVM>();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         widget.onToggleFavorite(widget.productId);
//         setState(() {}); // This will update the icon immediately
//       },
//       child: CircleAvatar(
//         radius: 14,
//         backgroundColor: Colors.white,
//         child: SvgPicture.asset(
//           viewModel.isFavorite(widget.productId)
//               ? AssetsManager.selectedFavIcon
//               : AssetsManager.favIcon,
//           width: viewModel.isFavorite(widget.productId) ? 33.w : 27.w,
//           height: viewModel.isFavorite(widget.productId) ? 33.h : 27.h,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:trendista_e_commerce/core/utils/assets_manager.dart';
import 'package:trendista_e_commerce/providers/favorite_provider.dart';

class CustomFavoriteIconButton extends StatelessWidget {
  final String productId;

  CustomFavoriteIconButton({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return GestureDetector(
      onTap: () {
        favoriteProvider.addOrRemoveFavorite(productId);
      },
      child: CircleAvatar(
        radius: 14,
        backgroundColor: Colors.white,
        child: SvgPicture.asset(
          favoriteProvider.isFavorite(productId)
              ? AssetsManager.selectedFavIcon
              : AssetsManager.favIcon,
          width: favoriteProvider.isFavorite(productId) ? 33.w : 27.w,
          height: favoriteProvider.isFavorite(productId) ? 33.h : 27.h,
        ),
      ),
    );
  }
}
