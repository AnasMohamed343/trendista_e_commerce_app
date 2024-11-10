// // Define an Order class to represent the order data
// class Order {
//   final String id;
//   final double amount;
//   final String status;
//   final String created_at;
//   // ... other order properties
//
//   Order(
//       {required this.id,
//       required this.amount,
//       required this.status,
//       required this.created_at});
//
//   factory Order.fromJson(Map<String, dynamic> json) {
//     return Order(
//       id: json['id'].toString(),
//       amount: (json['amount_cents'] as int).toDouble() / 100,
//       status: json['status'],
//       created_at: json['created_at'],
//       // ... map other properties
//     );
//   }
//
//   @override
//   String toString() {
//     return 'Order(id: $id, amount: $amount, status: $status, created_at: $created_at)';
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'amount_cents': (amount * 100).toInt(),
//       'status': status,
//       'created_at': created_at
//     };
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'amount_cents': (amount * 100).toInt(),
//       'status': status,
//       'created_at': created_at
//     };
//   }
// }
