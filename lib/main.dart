import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pchess/helper/init.dart';
import 'package:pchess/screens/online_offline_selection_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        // theme: ThemeData.dark(),
        theme: ThemeData(primarySwatch: Colors.teal),
        // theme: ThemeData(

        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        //   useMaterial3: true,
        // ),

        home: const OnlineOfflineSelectionScreen());
  }
}
