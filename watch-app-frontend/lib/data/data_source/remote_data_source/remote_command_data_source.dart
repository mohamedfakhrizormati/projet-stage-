import 'dart:convert';

import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/utils/api_const.dart';
import 'package:clean_arch/data/data_source/local_data_source/authentication_local_data_source.dart';
import 'package:clean_arch/data/data_source/local_data_source/settings_local_data_source.dart';
import 'package:clean_arch/data/models/command_model.dart';
import 'package:clean_arch/data/models/sales_model.dart';
import 'package:clean_arch/data/models/token_model.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class CommandRemoteDataSource {
  Future<CommandModel> createCommand(CommandModel newCommand);
  Future<CommandModel> getCommandById(String commandId);
  Future<List<CommandModel>> getAllCommands(String userId);
  Future<void> updateCommandstatus(String commandId, String status);
}

class CommandRemoteDataSourceImpl implements CommandRemoteDataSource {
  Future<TokenModel?> get token async {
    return await AuthenticationLocalDataSourceImpl().getUserInformations();
  }

  Future<String> get locale async {
    return await SettingsLocalDataSourcImpl().loadLocale();
  }

  @override
  Future<CommandModel> createCommand(CommandModel newCommand) async {
    try {
      String authToken = await token.then((value) => value!.token);
      final url = Uri.parse(ApiConst.addCommand);
      final body = jsonEncode(newCommand.tojson());

      final res = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: body,
      );

      print("Response Status Code: ${res.statusCode}");
      print("Response Body: ${res.body}");

      if (res.statusCode == 200 || res.statusCode == 201) {
        final data = jsonDecode(res.body);
        return CommandModel.fromJson(data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  @override
  Future<CommandModel> getCommandById(String commandId) async {
    try {
      final uri = Uri.parse('${ApiConst.getOneCommand}/$commandId');
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final body = json.decode(res.body);
        return CommandModel.fromJson(body);
      } else if (res.statusCode == 404) {
        throw ProductNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CommandModel>> getAllCommands(String userId) async {
    try {
      final authToken = await token.then((value) => value!.token);
      final res = await http.get(
        Uri.parse('${ApiConst.getAllCommands}/$userId'),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );
      if (res.statusCode == 200) {
        List<dynamic> body = json.decode(res.body);
        return body.map((e) => CommandModel.fromJson(e)).toList();
      } else if (res.statusCode == 404) {
        throw CommandNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateCommandstatus(String commandId, String status) async {
    try {
      final authToken = await token.then((value) => value!.token);
      final url = Uri.parse("${ApiConst.updateCommandStatus}/$commandId");
      final body = jsonEncode({'commandStatus': status});
      final res = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: body,
      );
      if (res.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      print("object Command: ${e.toString()}");
      rethrow;
    }
  }
}
