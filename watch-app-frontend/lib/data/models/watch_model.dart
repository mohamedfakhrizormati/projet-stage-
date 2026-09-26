import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:flutter/foundation.dart';

class WatchModel extends Watch {
  const WatchModel(
      {required super.id,
      required super.name,
      required super.image,
      super.model3d,
      required super.price,
      required super.brand,
      required super.category,
      required super.reference,
      required super.description,
      required super.size,
      required super.quantity,
      super.saleCount});

  factory WatchModel.fromJson(Map<String, dynamic> json) => WatchModel(
        id: json['_id'],
        name: json['name'],
        image: json['image'],
        model3d: json['model3d'],
        price: double.parse(json['price'].toString()),
        brand: json['brand'],
        category: json['category'],
        reference: json['reference'],
        description: json['description'],
        size: json['size'],
        quantity: json['quantity'],
        saleCount: json['saleCount'],
      );

  Map<String, dynamic> tojson() => {
        '_id': id,
        'name': name,
        'image': image,
        'model3d': model3d,
        'price': price,
        'brand': brand,
        'category': category,
        'reference': reference,
        'description': description,
        'size': size,
        'quantity': quantity,
        'saleCount': saleCount
      };
}
