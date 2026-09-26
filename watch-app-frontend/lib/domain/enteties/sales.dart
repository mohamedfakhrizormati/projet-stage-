import 'package:equatable/equatable.dart';

class Sales extends Equatable {
  String? id;
  int quantity;
  double totalPrice;
  final String userId;
  final String watchId;

  Sales(
      {this.id,
      required this.quantity,
      required this.totalPrice,
      required this.userId,
      required this.watchId});

  @override
  List<Object?> get props => [id, quantity, totalPrice, userId, watchId];
}
