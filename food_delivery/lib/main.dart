import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Provider/cart_provider.dart';
import 'package:food_delivery/Provider/foods_fact_provider.dart';
import 'package:food_delivery/view/app_onboard_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (create) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (create) => FoodFactsProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Feast Fetch',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 68, 136, 213)),
          useMaterial3: true,
        ),
        home: const AppOnBoardPage(),
      ),
    );
  }
}
