import 'package:clean_arch/domain/enteties/command.dart';

class User {
  final String? id;
  final String firstName;
  final String lastName;
  final String image;
  final String email;
  final String adresse;
  final String phone;
  final String gender;
  final DateTime birthDate;
  final List<String> commandHistory;
  final String password;

  const User(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.image,
      required this.email,
      required this.adresse,
      required this.phone,
      required this.gender,
      required this.birthDate,
      this.commandHistory = const [],
      required this.password});
}
