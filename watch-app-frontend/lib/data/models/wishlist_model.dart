import 'package:clean_arch/data/models/watch_model.dart';
import 'package:clean_arch/domain/enteties/wishlist.dart';

class WishlistModel extends Wishlist {
  WishlistModel(
      {required super.id, required super.userId, required super.watchs});

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
      id: json['_id'],
      userId: json['userId'],
      watchs: (json['watches'] as List).map((e) => e.toString()).toList());

  Map<String, dynamic> toJson() =>
      {"userId": userId, "watches": watchs.map((e) => id).toList()};
}
