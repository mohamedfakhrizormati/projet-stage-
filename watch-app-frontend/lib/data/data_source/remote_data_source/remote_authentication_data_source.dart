import 'dart:convert';
import 'dart:io';

import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/utils/api_const.dart';
import 'package:clean_arch/data/data_source/local_data_source/authentication_local_data_source.dart';
import 'package:clean_arch/data/data_source/local_data_source/settings_local_data_source.dart';
import 'package:clean_arch/data/models/token_model.dart';
import 'package:clean_arch/data/models/user_model.dart';
import 'package:clean_arch/domain/enteties/token.dart';
import 'package:clean_arch/domain/enteties/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

abstract class AuthenticationRemoteDataSource {
  Future<String> createAccount(
    String firstName,
    String lastName,
    String image,
    String email,
    String adresse,
    String phone,
    String gender,
    DateTime birthDate,
    String password,
  );

  Future<TokenModel> login(String email, String password);
  Future<void> updateUser(
    String id,
    String firstName,
    String lastName,
    String adresse,
    String phone,
    String gender,
    DateTime birthDate,
  );

  Future<void> updateImage(String userId, File image);

  Future<void> updatePassword(
      String userId, String oldPassword, String newPassword);

  Future<User> getOneUser(String userId);

  Future<TokenModel?> autoLogin();

  Future<void> forgetPassword(
      {required String email, required String destination});
  Future<void> verifyOTP(String email, int otp);
  Future<void> resetPassword(String email, String password);
  Future<void> clearUserImage(String userId);
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  Future<TokenModel?> get token async {
    return await AuthenticationLocalDataSourceImpl().getUserInformations();
  }

  Future<String> get locale async {
    return await SettingsLocalDataSourcImpl().loadLocale();
  }

  @override
  Future<String> createAccount(
      String firstName,
      String lastName,
      String image,
      String email,
      String adresse,
      String phone,
      String gender,
      DateTime birthDate,
      String password) async {
    try {
      AppLocalizations t =
          await AppLocalizations.delegate.load(Locale(await locale));

      UserModel userModel = UserModel(
          firstName: firstName,
          lastName: lastName,
          image: image ?? '',
          email: email,
          adresse: adresse,
          phone: phone,
          gender: gender,
          birthDate: birthDate,
          commandHistory: [],
          password: password);
      Map<String, dynamic> requestData = userModel.tojson();
      final url = Uri.parse(ApiConst.register);
      print(requestData.toString());
      final res = await http.post(
        url,
        body: {
          "firstName": firstName,
          "lastName": lastName,
          "image": image,
          "email": email,
          "adresse": adresse,
          "phone": phone,
          "gender": gender,
          "birthDate": birthDate.toString(),
          // "commandHistory": [],
          "password": password
        },
      );
      print(res.body);
      if (res.statusCode == 201) {
        final responseData = jsonDecode(res.body);
        return responseData['uid'];
      } else if (res.statusCode == 403) {
        throw RegistrationException(t.email_already_used);
      } else {
        throw ServerException(message: "Error: ${res.body}");
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<User> getOneUser(String userId) async {
    try {
      final uri = Uri.parse('${ApiConst.getOneUser}/$userId');
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final body = json.decode(res.body);
        return UserModel.fromJson(body);
      } else if (res.statusCode == 404) {
        throw UserNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TokenModel> login(String email, String password) async {
    String msg = "";
    AppLocalizations t =
        await AppLocalizations.delegate.load(Locale(await locale));
    try {
      Map<String, dynamic> user = {'email': email, 'password': password};
      final url = Uri.parse(ApiConst.login);
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final TokenModel token = TokenModel.fromJson(data);
        return token;
      } else {
        switch (res.statusCode) {
          case 202:
            msg = t.wrong_password;
            break;
          case 404:
            msg = t.email_not_registred;
            break;
          default:
        }
        throw LoginException(msg);
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateImage(String userID, File file) async {
    try {
      final url =
          Uri.parse(ApiConst.updateUserImage); // Replace with your API endpoint
      // Create a multipart request
      var request = http.MultipartRequest('POST', url);

      // Add fields
      request.fields['id'] = userID;

      // Add the file
      var fileName = file.path.split('/').last;
      request.files.add(
        await http.MultipartFile.fromPath(
          'file', // This should match the field name expected by the server
          file.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      // Send the request
      var response = await request.send();
    } catch (e) {
      throw ServerException(message: 'cannot update image');
    }
  }

  @override
  Future<void> clearUserImage(String userId) async {
    try {
      Map<String, dynamic> model = {'id': userId, 'image': ''};
      await http.put(
        Uri.parse(ApiConst.updateUser),
        body: model,
        headers: {
          "authorization":
              "Bearer ${await token.then((value) => value!.token)}",
        },
      );
    } catch (e) {
      throw ServerException(message: 'cannot update profile');
    }
  }

  @override
  Future<void> updatePassword(
      String userId, String oldPassword, String newPassword) async {
    try {
      AppLocalizations t =
          await AppLocalizations.delegate.load(Locale(await locale));

      Map<String, dynamic> requestData = {
        'id': userId,
        'oldPassword': oldPassword,
        'newPassword': newPassword
      };

      String authToken = await token.then((value) => value!.token);

      final url = Uri.parse(ApiConst.updateUserPassword);
      final res = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(requestData),
      );
      if (res.statusCode == 202) {
        throw DataNotFoundException(t.wrong_password);
      } else if (res.statusCode == 500) {
        throw ServerException(message: "server error");
      } else if (res.statusCode != 200) {
        throw Exception('Unexpected error: ${res.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateUser(
    String id,
    String firstName,
    String lastName,
    String adresse,
    String phone,
    String gender,
    DateTime birthDate,
  ) async {
    try {
      Map<String, dynamic> userModel = {
        'firstName': firstName,
        'lastName': lastName,
        'adresse': adresse,
        'phone': phone,
        'gender': gender,
        'birthDate': birthDate.toString(),
      };

      String authToken = await token.then((value) => value!.token);
      final url = Uri.parse('${ApiConst.updateUser}/$id');
      final res = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(userModel),
      );
      if (res.statusCode != 200) {
        throw ServerException(message: 'Cannot update user');
      }
    } catch (e) {
      throw ServerException(message: 'Cannot update profile: ${e.toString()}');
    }
  }

  @override
  Future<TokenModel?> autoLogin() async {
    try {
      return await token;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<void> forgetPassword(
      {required String email, required String destination}) async {
    try {
      AppLocalizations t =
          await AppLocalizations.delegate.load(Locale(await locale));
      final response = await http.post(
        Uri.parse(ApiConst.forgetPassword),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "destination": destination}),
      );

      if (response.statusCode == 404) {
        throw DataNotFoundException(t.email_not_registred);
      } else if (response.statusCode == 500) {
        throw ServerException(message: "server error");
      } else if (response.statusCode != 200) {
        throw Exception("Unexpected error: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email, String password) async {
    try {
      AppLocalizations t =
          await AppLocalizations.delegate.load(Locale(await locale));
      final response = await http.post(
        Uri.parse(ApiConst.resetPassword),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 404) {
        throw DataNotFoundException(t.email_not_registred);
      } else if (response.statusCode == 500) {
        throw ServerException(message: "error");
      } else if (response.statusCode != 200) {
        throw Exception("Unexpected error: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> verifyOTP(String email, int otp) async {
    try {
      AppLocalizations t =
          await AppLocalizations.delegate.load(Locale(await locale));
      final response = await http.post(
        Uri.parse(ApiConst.verifyOTP),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "otp": otp}),
      );

      if (response.statusCode == 404) {
        throw BadOTPException(t.code_invalid);
      } else if (response.statusCode == 400) {
        throw BadOTPException(t.expired_code);
      } else if (response.statusCode != 200) {
        throw Exception("Unexpected error: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
