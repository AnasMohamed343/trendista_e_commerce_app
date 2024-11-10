import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:trendista_e_commerce/di/di.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/usecases/get_product_details_usecase.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/carts/cart_vm.dart';

@injectable
class ProductDetailsVM extends Cubit<ProductDetailsState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;
//   int selectedQuantity = 1; // Default to 1
//   @factoryMethod
//   ProductDetailsVM({required this.getProductDetailsUseCase})
//       : super(LoadingState(message: 'Loading...'));
//
//   // void initPage(int productId) async {
//   //   emit(LoadingState(message: 'Loading...'));
//   //   try {
//   //     var productDetails = await getProductDetailsUseCase.invoke(productId);
//   //     emit(SuccessState(productDetails: productDetails));
//   //   } catch (e) {
//   //     emit(ErrorState(errorMessage: e.toString()));
//   //   }
//   // }
//   void initPage(int productId) async {
//     emit(LoadingState(message: 'Loading...'));
//     try {
//       var productDetails = await getProductDetailsUseCase.invoke(productId);
//       var initialTotalPrice = (productDetails?.price ?? 0) *
//           selectedQuantity; // Calculate total price initially
//       emit(SuccessState(
//           productDetails: productDetails, totalPrice: initialTotalPrice));
//     } catch (e) {
//       emit(ErrorState(errorMessage: e.toString()));
//     }
//   }
//
//   //  // // update the quantity directly in the details and cart
//   //  void updateQuantity(int quantity) {
//   //    selectedQuantity = quantity;
//   //    if (state is SuccessState) {
//   //      var productDetails = (state as SuccessState).productDetails;
//   //      var price = productDetails?.price ?? 0;
//   //      var totalPrice = price * selectedQuantity; // Recalculate total price
//   //      emit(
//   //          SuccessState(productDetails: productDetails, totalPrice: totalPrice));
//   //    }
//   //  }
//   // update the quantity not directly in the cart
//   void updateQuantity(int quantity) {
//     selectedQuantity = quantity;
//
//     // Ensure state is cast to SuccessState to access productDetails
//     if (state is SuccessState) {
//       final successState = state as SuccessState;
//       emit(SuccessState(
//         productDetails:
//             successState.productDetails, // Re-use existing productDetails
//         totalPrice:
//             calculateTotalPrice(successState.productDetails?.price ?? 0),
//       ));
//     }
//   }
//
// // Calculate total price based on selected quantity
//   int calculateTotalPrice(int productPrice) {
//     return productPrice * selectedQuantity;
//   }
// }

  // Store selected quantity for each product by product ID
  Map<int, int> productQuantities = {};

  @factoryMethod
  ProductDetailsVM({required this.getProductDetailsUseCase})
      : super(LoadingState(message: 'Loading...'));

  void initPage(int productId) async {
    emit(LoadingState(message: 'Loading...'));
    try {
      var productDetails = await getProductDetailsUseCase.invoke(productId);

      // Set the default quantity for this product if it's not set yet
      if (!productQuantities.containsKey(productId)) {
        productQuantities[productId] = 1; // Default quantity is 1
      }

      var initialTotalPrice = (productDetails?.price ?? 0) *
          productQuantities[productId]!; // Calculate total price initially
      emit(SuccessState(
          productDetails: productDetails, totalPrice: initialTotalPrice));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  // Update the quantity for the specific product
  void updateQuantity(int productId, int quantity) {
    // Update the quantity only for the specific product
    productQuantities[productId] = quantity;

    // Ensure state is cast to SuccessState to access productDetails
    if (state is SuccessState) {
      final successState = state as SuccessState;

      // Update the state only for the relevant product
      emit(SuccessState(
        productDetails: successState.productDetails,
        totalPrice: calculateTotalPrice(
            successState.productDetails?.price ?? 0, productId),
      ));
    }
  }

  final cartProvider = getIt<CartVM>();

  // Calculate total price based on selected quantity
  int? calculateTotalPrice(int productPrice, int productId) {
    var totalPrice =
        productPrice * cartProvider.getQuantity(productId.toString());
    print(totalPrice);

    return totalPrice;
  }

  // clear the quantity for the specific product and the total price after the quantity is updated
  void clearQuantity(int productId) {
    productQuantities[productId] = 1;
    if (state is SuccessState) {
      final successState = state as SuccessState;
      emit(SuccessState(
        productDetails: successState.productDetails,
        totalPrice: calculateTotalPrice(
            successState.productDetails?.price ?? 0, productId),
      ));
    }
  }
}

sealed class ProductDetailsState {}

class LoadingState extends ProductDetailsState {
  final String message;
  LoadingState({required this.message});
}

class ErrorState extends ProductDetailsState {
  final String? errorMessage;
  ErrorState({this.errorMessage});
}

class SuccessState extends ProductDetailsState {
  final Product? productDetails;
  final int? totalPrice;
  SuccessState({this.productDetails, this.totalPrice});
}
