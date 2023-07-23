import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pchess/components/app_text.dart';
import 'package:pchess/controlers/chess_bord_controler.dart';
import 'package:pchess/helper/route_helper.dart';
import 'package:pchess/screens/chess_game_board_screen.dart';

class JoinOnlineChessScreen extends StatelessWidget {
  const JoinOnlineChessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Rx<bool> isLoding = false.obs;
    String selectedChessBoardId = "";
    return Scaffold(
      appBar: AppBar(
          title: const AppText(
        text: "Join the Game",
      )),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: (value) => selectedChessBoardId = value,
            decoration: InputDecoration(
                hintText: "Chess Board Id",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(() => ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
                padding: MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(
                        horizontal: Get.width / 2 - 100, vertical: 15))),
            onPressed: () {
              isLoding.value = true;
              Get.find<ChessBordControler>()
                  .joinChessBoard(selectedChessBoardId)
                  .then((isJoined) {
                if (isJoined) {
                  replaceScreen(
                      context: context, screen: const ChessGameScreen());
                } else {
                  Get.snackbar(
                      "wrong Chess Board", "try to correct and rejoin");
                  isLoding.value = false;
                }
              });
            },
            child: isLoding.value
                ? const CircularProgressIndicator(
                    color: Colors.white,
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                  )
                : const AppText(
                    text: "Join & Play ",
                    fontSize: 25,
                  )))
      ]),
    );
  }
}
