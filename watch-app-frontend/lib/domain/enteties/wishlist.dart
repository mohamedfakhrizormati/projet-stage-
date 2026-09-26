import 'package:clean_arch/domain/enteties/watch.dart';

class Wishlist {
  final String id;
  final String userId;
  List<String> watchs;

  Wishlist({required this.id, required this.userId, required this.watchs});
}
