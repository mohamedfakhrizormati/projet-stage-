import 'package:clean_arch/presentation/controller/authentication_controller.dart';
import 'package:clean_arch/presentation/screens/auth-screens/login-page.dart';
import 'package:clean_arch/presentation/screens/auth-screens/update-password-screen.dart';
import 'package:clean_arch/presentation/screens/cart-screen.dart';
import 'package:clean_arch/presentation/screens/main-screen.dart';
import 'package:clean_arch/presentation/screens/profile-screens/edit-profile-screen.dart';
import 'package:clean_arch/presentation/screens/favorites-screen.dart';
import 'package:clean_arch/presentation/screens/home-screen.dart';
import 'package:clean_arch/presentation/screens/profile-screens/profile-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DrawerContents extends StatelessWidget {
  const DrawerContents({super.key});

  get userFirstName => null;

  get userEmail => null;

  get userImage => null;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          //top container
          GetBuilder<AuthenticationController>(builder: (controller) {
            return UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                accountName: Text(
                  controller.currentUser.firstName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Merriweather',
                  ),
                ),
                //userFirstName
                accountEmail: Text(
                  controller.currentUser.email,
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 15,
                      fontFamily: 'Merriweather',
                      color: Color(0xFF858585)),
                ),
                //userEmail
                currentAccountPicture: Container(
                  height: 200, // Height for the CircleAvatar container
                  width: 200, // Width for the CircleAvatar container
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // Ensures it's a circle
                    color: const Color(0xFF858585), // Default gray background
                  ),
                  child: CircleAvatar(
                    backgroundImage: controller.currentUser.image == ''
                        ? Image.asset('assets/images/userImage.jpg').image
                        : NetworkImage(controller.currentUser.image!),
                    radius: 60.r,
                  ),
                ));
          }),
          ListTile(
            leading: Icon(
              Icons.home_outlined,
              size: 30,
              color: Colors.black54,
            ),
            title: Text(
              "Home",
              style: TextStyle(
                  fontFamily: 'Merriweather',
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MainScreen(),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.person_outline,
          //     size: 30,
          //     color: Colors.black54,
          //   ),
          //   title: Text(
          //     "Profile",
          //     style: TextStyle(
          //         fontFamily: 'Merriweather',
          //         fontWeight: FontWeight.w600,
          //         fontSize: 20),
          //   ),
          //   onTap: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (_) => ProfilePage(),
          //       ),
          //     );
          //   },
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          ListTile(
              leading: Icon(
                Icons.favorite_outline,
                size: 30,
                color: Colors.black54,
              ),
              title: Text(
                "Favorites",
                style: TextStyle(
                    fontFamily: 'Merriweather',
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesScreen()),
                );
              }),
          SizedBox(
            height: 10,
          ),
          // ListTile(
          //     leading: Icon(
          //       Icons.shopping_bag_outlined,
          //       size: 30,
          //       color: Colors.black54,
          //     ),
          //     title: Text(
          //       "Cart",
          //       style: TextStyle(
          //           fontFamily: 'Merriweather',
          //           fontWeight: FontWeight.w600,
          //           fontSize: 20),
          //     ),
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => CartPage()),
          //       );
          //     }),
          // SizedBox(
          //   height: 10,
          // ),
          ListTile(
            leading: Icon(
              Icons.notifications_outlined,
              size: 30,
              color: Colors.black54,
            ),
            title: Text(
              "Notifications",
              style: TextStyle(
                  fontFamily: 'Merriweather',
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            onTap: () => null,
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(
              Icons.settings_outlined,
              size: 30,
              color: Colors.black54,
            ),
            title: Text(
              "Settings",
              style: TextStyle(
                  fontFamily: 'Merriweather',
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            onTap: () => null,
          ),

          Spacer(),
          Divider(),
          SizedBox(
            height: 10,
          ),
          ListTile(
              leading: Icon(
                Icons.logout,
                size: 30,
                color: Colors.black54,
              ),
              title: Text(
                "Log Out",
                style: TextStyle(
                    fontFamily: 'Merriweather',
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
              onTap: () async {
                final AuthenticationController authenticationController =
                    Get.find();
                await authenticationController.logout(context);
              }),
        ],
      ),
    );
  }
}
