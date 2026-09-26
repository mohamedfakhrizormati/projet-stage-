import 'package:clean_arch/presentation/controller/authentication_controller.dart';
import 'package:clean_arch/presentation/screens/auth-screens/update-password-screen.dart';
import 'package:clean_arch/presentation/screens/profile-screens/edit-profile-screen.dart';
import 'package:clean_arch/presentation/widgets/headers/Payment-header.dart';
import 'package:clean_arch/presentation/widgets/buttons/custom-text-button.dart';
import 'package:clean_arch/presentation/widgets/image-container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat("yyyy-MM-dd");

    return Scaffold(
      body: Column(
        children: [
          PaymentHeader(title: "Profile"),
          Expanded(
            child: GetBuilder<AuthenticationController>(builder: (controller) {
              return SingleChildScrollView(
                child: Container(
                  color: Colors.black,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ImageContainer(),
                            const SizedBox(height: 20),
                            CustomTextButton(
                                width: 150,
                                height: 40,
                                color: Color(0xFFAF6767),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => EditProfilePage(),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.edit_outlined),
                                text: "Edit Profile",
                                textColor: Colors.white),
                            const SizedBox(height: 20),
                            CustomTextButton(
                                width: 150,
                                height: 40,
                                color: Color(0xFFAF6767),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => UpdatePasswordPage(),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.lock_outlined),
                                text: "Edit Password",
                                textColor: Colors.white),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: TextEditingController(
                                  text: controller.currentUser.firstName),
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: "First Name",
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: TextEditingController(
                                  text: controller.currentUser.lastName),
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: "Last Name",
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: TextEditingController(
                                  text: controller.currentUser.adresse),
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: "Adresse",
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: TextEditingController(
                                  text: controller.currentUser.phone),
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: "Phone",
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: TextEditingController(
                                  text: controller.currentUser.gender),
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: "Gender",
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: TextEditingController(
                                  text: format.format(
                                      controller.currentUser.birthDate)),
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: "BirthDate",
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
