import 'package:clean_arch/domain/enteties/category.dart';

class CategoryModel extends Category {
  CategoryModel({required super.id, required super.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(id: json['_id'], name: json['name']);

  Map<String, dynamic> tojson() => {'_id': id, 'name': name};
}
