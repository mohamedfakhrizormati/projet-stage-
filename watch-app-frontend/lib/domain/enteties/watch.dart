import 'package:equatable/equatable.dart';

class Watch extends Equatable {
  final String id;
  final String name;
  final String image;
  final String? model3d;
  final double price;
  final String brand;
  final String category;
  final String reference;
  final String description;
  final String size;
  final int quantity;
  final int? saleCount;

  const Watch({
    required this.id,
    required this.name,
    required this.image,
    this.model3d,
    required this.price,
    required this.brand,
    required this.category,
    required this.reference,
    required this.description,
    required this.size,
    required this.quantity,
    this.saleCount = 0,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        image,
        model3d,
        price,
        brand,
        category,
        reference,
        description,
        size,
        quantity,
        saleCount
      ];
}
