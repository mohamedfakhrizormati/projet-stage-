import 'package:clean_arch/di.dart';
import 'package:clean_arch/domain/enteties/command.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:clean_arch/domain/usecases/command_usecases/create_command_usecase.dart';
import 'package:clean_arch/domain/usecases/command_usecases/get_command_by_id_usecase.dart';
import 'package:clean_arch/domain/usecases/command_usecases/update_command_status_usecase.dart';
import 'package:clean_arch/domain/usecases/sales_usecases/get_sales_by_id_usecase.dart';
import 'package:clean_arch/domain/usecases/watch_usecases/get_watch_by_id_usecase.dart';
import 'package:clean_arch/presentation/controller/authentication_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CommandController extends GetxController {
  List<Sales> commandSales = [];
  List<Watch> commandWatchs = [];

  Future<Command> getCommand(String userId) async {
    late Command currentCommand;
    final res = await GetCommandByIdUsecase(sl())(userId);
    res.fold((l) => null, (r) => currentCommand = r);
    return currentCommand;
  }

  Future<Command?> createCommand(Command newCommand) async {
    Command? rr;
    final res = await CreateCommandUsecase(sl())(newCommand);
    res.fold((l) => throw l, (r) {
      return rr = r;
    });
    return rr;
  }

  Future<void> updateCommandStatus(String commandId, String status) async {
    await UpdateCommandStatusUsecase(sl())(commandId, status);
  }

  Future<void> getCommandWatchs() async {
    print("cart $commandSales 0");
    for (var element in commandSales) {
      final res = await GetWatchByIdUsecase(sl())(wID: element.watchId);
      res.fold((l) => null, (r) => commandWatchs.add(r));
    }
  }

  final AuthenticationController authenticationController = Get.find();
  Future<List<Sales>> getCommandSales() async {
    Command currentCommand =
        await getCommand(authenticationController.currentUser.id!);
    commandSales = [];
    print("sale before $commandSales 1");
    print("products before ${currentCommand.sales}");

    for (var element in currentCommand.sales) {
      final res = await GetSalesByIdUsecase(sl())(element);
      res.fold((l) => null, (r) {
        commandSales.add(r);
      });
      print("sale after $commandSales 2");
    }

    return commandSales;
  }
}
