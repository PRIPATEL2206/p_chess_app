import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:pchess/controlers/chess_bord_controler.dart';
import 'package:pchess/firebase_options.dart';

Future<void> init() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.lazyPut(() => ChessBordControler());

// initiate chess bord
  Get.find<ChessBordControler>().initateChessBord();
}
