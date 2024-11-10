import 'package:dio/dio.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/services/paymob_manager/order_model.dart';

class PayMobManager {
  Future<String> getPaymentKey(int amount, String currency) async {
    try {
      //1- who wants to pay
      String authenticationToken = await _getAuthenticationToken();
      //2- order registration api , how much he will pay
      int orderId = await _getOrderId(
        authenticationToken: authenticationToken,
        amount: (100 * amount).toString(),
        currency: currency,
      );
      //3- payment registration api paymentKey
      String paymentKey = await _getPaymentKey(
        authenticationToken: authenticationToken,
        orderId: orderId.toString(),
        amount: (100 * amount).toString(),
        currency: currency,
      );

      return paymentKey;
    } catch (e) {
      print("Exc====atPayMobManager===========");
      print(e.toString());
      throw Exception();
    }
  }

  static Future<String> _getAuthenticationToken() async {
    //2- get authentication token
    final Response response = await Dio().post(
      'https://accept.paymob.com/api/auth/tokens',
      data: {
        'api_key': kPayMobApiKey,
      },
    );
    return response.data["token"];
  }

  //make getter for _getAuthenticationToken
  //static Future<String> getAuthenticationToken() => _getAuthenticationToken();

  Future<int> _getOrderId({
    required String authenticationToken,
    required String amount,
    required String currency,
  }) async {
    final Response response = await Dio().post(
      'https://accept.paymob.com/api/ecommerce/orders',
      data: {
        "auth_token": authenticationToken,
        "delivery_needed": "false",
        "amount_cents": amount, // as String
        "currency": currency,
        "items": [],
      },
    );
    return response.data["id"];
  }

  Future<String> _getPaymentKey({
    required String authenticationToken,
    required String orderId,
    required String amount,
    required String currency,
  }) async {
    final Response response = await Dio()
        .post('https://accept.paymob.com/api/acceptance/payment_keys', data: {
      //all of them are required
      "expiration":
          3600, // the number of seconds before this payment key expires
      "order_id": orderId, // from second api , must send it as a string
      "auth_token": authenticationToken,
      "integration_id":
          kCardPaymentMethodIntegrationId, //integration id from the payment method
      "amount_cents": amount,
      "currency": currency,
      "billing_data": {
        //have to be values
        "first_name": "Clifford",
        "last_name": "Nicolas",
        "phone_number": "+86(8)9135210487",
        "email": "claudette09@exa.com",

        //can set "NA"
        "apartment": "NA",
        "floor": "NA",
        "street": "NA",
        "building": "NA",
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "state": "NA"
      }
    });
    return response.data["token"];
  }

//   static Future<List<Order>> getUserOrders() async {
//     final Response response = await Dio().get(
//       'https://accept.paymob.com/api/ecommerce/orders',
//     );
//     return (response.data as List)
//         .map((e) => Order.fromJson(e))
//         .toList();
//   }
// }
//   /// Fetch orders from Paymob API
//   static Future<List<Map<String, dynamic>>> getOrders(
//       String authenticationToken) async {
//     try {
//       final response = await Dio().get(
//         'https://accept.paymob.com/api/ecommerce/orders',
//         options: Options(
//           headers: {
//             "Authorization":
//                 "Bearer $authenticationToken", // Bearer token format
//           },
//         ),
//         queryParameters: {
//           "auth_token": authenticationToken,
//         },
//       );
//
//       // Check and handle the response data
//       if (response.statusCode == 200) {
//         List<Map<String, dynamic>> orders =
//             List<Map<String, dynamic>>.from(response.data);
//         return orders;
//       } else {
//         throw Exception(
//             "Failed to fetch orders, status code: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error fetching orders: $e");
//       throw Exception(e.toString());
//     }
//   }
}
// import 'package:http/http.dart' as http;
// import 'package:trendista_e_commerce/constants.dart';
//
// class PayMobManager{
//   Future<String> getPaymentKey(int amount, String currency) async {
//     //1- who wants to pay
//     String authenticationToken = await _getAuthenticationToken();
//     //2- order registration api , how much he will pay
//     int orderId =;
//   }
//
//   Future<String> _getAuthenticationToken() async {
//     //2- get authentication token
//     var url = Uri.https(
//       'accept.paymob.com/api/auth/tokens',
//     );
//     final response = await http.post(
//       url,
//       body: {
//         'api_key': kPayMobApiKey,
//       },
//     );
//     return response.body["token"];
//   }
//
//   Future<int> _getOrderId({
//     required String authenticationToken,
//     required String amount,
//     required String currency,
// }) async {
//     var url = Uri.https(
//       'accept.paymob.com/api/ecommerce/orders',
//     );
//     final response = await http.post(
//       url,
//       body: {
//         'auth_token': authenticationToken,
//         'delivery_needed': "false",
//         'amount_cents': amount,// as String
//         'currency': currency,// not required
//         'items': [],
//       },
//     );
//     return response.body["id"];
//   }
// }
