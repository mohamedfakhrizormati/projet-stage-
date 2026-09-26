import 'package:clean_arch/presentation/controller/authentication_controller.dart';
import 'package:clean_arch/presentation/screens/auth-screens/forget-password.dart';
import 'package:clean_arch/presentation/screens/home-screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: height * 0.2,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 60),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: const Text(
                            "Log In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Merriweather',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Form container
              Expanded(
                child: SingleChildScrollView(
                    child: Container(
                  color: Colors.black,
                  child: Container(
                    height: height * 0.8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            const Text(
                              "Let's Sign In",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Merriweather',
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Email
                            Container(
                              height: 40,
                              child: TextFormField(
                                controller: emailController,
                                validator: (v) {
                                  if (!v!.endsWith("@gmail.com") || v.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .invalid_email_address;
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  hintText: 'Example@gmail.com',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  prefixIcon: const Icon(Icons.email),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Password
                            Container(
                              height: 40,
                              child: TextFormField(
                                controller: passwordController,
                                validator: (p0) {
                                  if (p0!.isEmpty || p0.length < 8) {
                                    return AppLocalizations.of(context)!
                                        .invalid_password;
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  prefixIcon:
                                      const Icon(Icons.password_outlined),
                                  suffixIcon:
                                      const Icon(Icons.remove_red_eye_outlined),
                                ),
                              ),
                            ),
                            Align(
                              alignment:
                                  Alignment.centerRight, // Align to the left
                              child: TextButton(
                                onPressed: () {
                                  // Add your "forgot password" logic here
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ForgetPasswordPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Merriweather',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),

                            // Create Account button
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: GetBuilder(
                                  init: AuthenticationController(),
                                  builder: (controller) {
                                    return TextButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          await controller.login(
                                              email: emailController,
                                              password: passwordController,
                                              context: context);
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: AppLocalizations.of(context)!
                                                  .missing_data,
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.TOP,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                        print("Login successfully!");
                                      },
                                      child: Text(
                                        "Connect ",
                                        style: TextStyle(
                                          fontFamily: 'Merriweather',
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }),
                            ),

                            const SizedBox(height: 20),
                            // Create Account with facebook
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFFAF6767),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                  );
                                  // Handle account creation
                                  print("Account created!");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Centers the row content
                                  children: [
                                    const Icon(
                                      Icons
                                          .facebook, // This will use the default Facebook icon
                                      color: Colors.white,
                                      size: 24, // Adjust size as needed
                                    ),
                                    const SizedBox(
                                        width:
                                            10), // Adds space between icon and text
                                    const Text(
                                      "Connect with Facebook",
                                      style: TextStyle(
                                        fontFamily: 'Merriweather',
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Create Account button
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFFAF6767),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  // Handle account creation
                                  print("Account created!");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Centers the row content
                                  children: [
                                    const Icon(
                                      Icons
                                          .email, // This will use the default Facebook icon
                                      color: Colors.white,
                                      size: 24, // Adjust size as needed
                                    ),
                                    const SizedBox(
                                        width:
                                            10), // Adds space between icon and text
                                    const Text(
                                      "Connect with Google",
                                      style: TextStyle(
                                        fontFamily: 'Merriweather',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
