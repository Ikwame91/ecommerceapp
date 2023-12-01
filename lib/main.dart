import 'package:ecommerce_app/controllers/mainscreen_provider.dart';
import 'package:ecommerce_app/controllers/productscreen_provider.dart';
import 'package:ecommerce_app/controllers/tabs_prodivier.dart';
import 'package:ecommerce_app/ui/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainScreenNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductScreenNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => TabsNotifiier(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nkay Comerce',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen());
  }
}
