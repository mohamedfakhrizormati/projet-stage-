import 'package:clean_arch/data/models/command_model.dart';
import 'package:clean_arch/domain/enteties/user.dart';

class UserModel extends User {
  const UserModel(
      {super.id,
      required super.firstName,
      required super.lastName,
      required super.image,
      required super.email,
      required super.adresse,
      required super.phone,
      required super.gender,
      required super.birthDate,
      super.commandHistory,
      required super.password});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      image: json['image'],
      email: json['email'],
      adresse: json['adresse'],
      phone: json['phone'],
      gender: json['gender'],
      birthDate: DateTime.parse(json['birthDate']),
      commandHistory: (json['commandHistory'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      password: json['password']);

  Map<String, dynamic> tojson() => {
        'firstName': firstName,
        'lastName': lastName,
        'image': image,
        'email': email,
        'adresse': adresse,
        'phone': phone,
        'gender': gender,
        'birthDate': birthDate.toString(),
        'commandHistory': commandHistory,
        'password': password
      };
}
