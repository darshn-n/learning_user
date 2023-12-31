import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gsss_learning/providers/product_provider.dart';
import 'package:gsss_learning/screens/account_screen.dart';
import 'package:gsss_learning/screens/article_screen.dart';
import 'package:gsss_learning/screens/home_screen.dart';
import 'package:gsss_learning/screens/login_screen.dart';
import 'package:gsss_learning/screens/main_screen.dart';
import 'package:gsss_learning/screens/product_details_screen.dart';
import 'package:gsss_learning/screens/products_by_category.dart';
import 'package:gsss_learning/providers/category_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gsss_learning/screens/splash_screen.dart';
import 'package:gsss_learning/screens/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider(
          create: (_) => CategoryProvider(),
        ),
        ListenableProvider(
          create: (_) => ProductProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.cyan,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        MainScreen.id: (context) => const MainScreen(),
        ProductDetailsScreen.id: (context) => const ProductDetailsScreen(),
        ProductByCategory.id: (context) => const ProductByCategory(),
        AccountScreen.id: (context) => const AccountScreen(),
        ArticleScreen.id: (context) => const ArticleScreen(),
        WelcomeScreen.id: (context) => const WelcomeScreen(),
      },
    );
  }
}


