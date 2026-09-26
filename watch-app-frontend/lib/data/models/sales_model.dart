import 'package:clean_arch/domain/enteties/sales.dart';

class SalesModel extends Sales {
  SalesModel(
      {super.id,
      required super.quantity,
      required super.totalPrice,
      required super.userId,
      required super.watchId});

  factory SalesModel.fromJson(Map<String, dynamic> json) => SalesModel(
        id: json['_id'],
        quantity: json['quantity'],
        totalPrice: double.parse(json['totalPrice'].toString()),
        userId: json['userId'],
        watchId: json['watchId'],
      );

  Map<String, dynamic> tojson() => {
        'quantity': quantity,
        'totalPrice': totalPrice,
        'userId': userId,
        'watchId': watchId
      };
}
