import 'dart:async';
import 'package:clean_arch/core/utils/string_const.dart';
import 'package:clean_arch/di.dart';
import 'package:clean_arch/domain/usecases/authentication_usecases/auto_login_usecase.dart';
import 'package:clean_arch/domain/usecases/authentication_usecases/get_user_by_id_usecase.dart';
import 'package:clean_arch/presentation/controller/authentication_controller.dart';
import 'package:clean_arch/presentation/controller/cart_controller.dart';
import 'package:clean_arch/presentation/controller/category_controller.dart';
import 'package:clean_arch/presentation/controller/main_controller.dart';
import 'package:clean_arch/presentation/controller/watch_controller.dart';
import 'package:clean_arch/presentation/controller/wishlist_controller.dart';
import 'package:clean_arch/presentation/screens/auth-screens/login-page.dart';
import 'package:clean_arch/presentation/screens/main-screen.dart';
import 'package:clean_arch/presentation/screens/walcome-screens/screen-four.dart';
import 'package:clean_arch/presentation/screens/walcome-screens/screen-one.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _textOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animationController.forward();

    _textOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Navigate to the login page after 3 seconds
    // Future.delayed(const Duration(seconds: 3), () {
    //   if (mounted) {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => const LoginPage()),
    //     );
    //   }
    // });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  static Future<void> init(BuildContext context, int duration) async {
    //Get.put(SettingsController());
    Get.put(AuthenticationController());
    Get.put(WatchController());
    Get.put(CategoryController());
    Get.put(WishlistController());
    Get.put(CartController());
    // Get.put(VariantController());
    Get.put(MainController());

    // Get.put(MainScreenController());
    // Get.put(SupplierController());

    // Get.put(PromotionController());
    // final SettingsController settingsController = Get.find();
    final AuthenticationController authController = Get.find();
    final WatchController watchController = Get.find();
    final CategoryController categoryController = Get.find();
    final WishlistController wishListController = Get.find();
    final CartController cartController = Get.find();
    // final VariantController variantController = Get.find();
    final MainController mainController = Get.find();

    // final lang = await settingsController.loadLocale();
    // settingsController.setLocal(lang);
    bool res = true;
    final autologiVarReturn = await AutoLoginUsecase(sl()).call();
    autologiVarReturn.fold((l) {
      res = false;
    }, (r) async {
      print(r.toString());
      if (r != null) {
        authController.token = r;
        final user = await GetUserByIdUsecase(sl()).call(userId: r.userId);
        user.fold((l) {
          res = false;
        }, (r) async {
          authController.currentUser = r;
          await wishListController.getWishList(authController.currentUser.id!);
          await watchController.getAllWatchs();
          print(wishListController.currentWishlist.watchs);
          await cartController.getUserCart(authController.currentUser.id!);
          print(cartController.currentCart.sales);

          // Get.put(NotificationsController());
        });
        print(authController.currentUser.birthDate);
      } else {
        res = false;
      }
    });
    final sp = await SharedPreferences.getInstance();
    final data = sp.getBool(StringConst.SP_TUTORIAL_KEY) ?? false;

    Future.delayed(Duration(seconds: duration), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => res
                  ? const MainScreen()
                  : data
                      ? const ScreenFour()
                      : const ScreenOne()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FutureBuilder(
            future: init(context, 2),
            builder: (context, snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: Tween<double>(begin: 0, end: 1).animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/logo1.png',
                      height: 150,
                    ),
                  ),
                  ScaleTransition(
                    scale: Tween<double>(begin: 0, end: 1).animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: const Text(
                      'Where precision meets luxury',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Merriweather',
                        color: Color(0xFFAF6767),
                      ),
                    ),
                  ),
                  // FadeTransition(
                  //   opacity: _textOpacityAnimation,
                  //   child: const Text(
                  //     'Where precision meets luxury',
                  //     style: TextStyle(
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold,
                  //       fontFamily: 'Merriweather',
                  //       color: Color(0xFFAF6767),
                  //     ),
                  //   ),
                  // ),
                ],
              );
            }),
      ),
      bottomNavigationBar: const SizedBox(
        height: 20,
        child: Text(
          'Powered by Epic Valor X ',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFAF6767),
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
