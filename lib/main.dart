import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:luxora/core/routing/app_routes.dart';
import 'package:luxora/firebase_options.dart';
import 'package:luxora/viewmodels/auth_viewmodel.dart';
import 'package:luxora/viewmodels/home_view_model.dart';
import 'package:luxora/viewmodels/product_details_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const LuxoraApp());
}

class LuxoraApp extends StatelessWidget {
  const LuxoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AuthViewmodel(),
      ),ChangeNotifierProvider(create: (context) => HomeViewModel(),),ChangeNotifierProvider(create: (context) => ProductDetailsModelView(),)
    ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
  initialRoute:AppRoutes.splash,
  routes: AppRoutes.routes
));
  }
}
