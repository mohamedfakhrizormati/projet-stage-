import 'package:clean_arch/data/models/sales_model.dart';
import 'package:clean_arch/domain/enteties/cart.dart';

class CartModel extends Cart {
  CartModel({
    required super.id,
    required super.userId,
    required super.sales,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
      id: json['_id'] as String,
      userId: json['userId'] as String,
      sales: (json['sales'] as List).map((e) => e.toString()).toList());

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'sales': sales.map((sale) => (sale as SalesModel).tojson()).toList(),
      };
}
