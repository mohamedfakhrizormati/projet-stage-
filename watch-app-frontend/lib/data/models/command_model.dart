import 'package:clean_arch/data/models/sales_model.dart';
import 'package:clean_arch/domain/enteties/command.dart';

class CommandModel extends Command {
  const CommandModel(
      {super.id,
      required super.adresse,
      required super.reference,
      required super.commandTotalPrice,
      required super.commandDate,
      required super.commandStatus,
      required super.userId,
      required super.sales});

  factory CommandModel.fromJson(Map<String, dynamic> json) => CommandModel(
        id: json['_id'],
        adresse: json['adresse'],
        reference: json['reference'],
        commandTotalPrice: double.parse(json['commandTotalPrice'].toString()),
        commandDate: DateTime.parse(json['commandDate']),
        commandStatus: json['commandStatus'],
        userId: json['userId'],
        sales: List<String>.from(json['sales']),
        // sales: ((json['sales']) as List)
        //     .map((e) => SalesModel.fromJson(e as Map<String, dynamic>))
        //     .toList()
      );

  Map<String, dynamic> tojson() => {
        'adresse': adresse,
        'reference': reference,
        'commandTotalPrice': commandTotalPrice,
        'commandDate': commandDate.toString(),
        'commandStatus': commandStatus,
        'userId': userId,
        'sales': sales
      };
}
