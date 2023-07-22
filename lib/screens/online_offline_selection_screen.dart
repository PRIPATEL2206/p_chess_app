import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pchess/components/app_text.dart';
import 'package:pchess/helper/route_helper.dart';
import 'package:pchess/screens/chess_game_board_screen.dart';
import 'package:pchess/screens/join_online_chess_game.dart';
import 'package:pchess/screens/player_selection_screen.dart';

class OnlineOfflineSelectionScreen extends StatelessWidget {
  const OnlineOfflineSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ElevatedButton(
                  onPressed: () {
                    gotoScreen(
                        context: context, screen: const ChessGameScreen());
                  },
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                      padding: MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(
                              horizontal: Get.width / 2 - 100, vertical: 15))),
                  child: const AppText(
                    fontSize: 30,
                    text: "Play Offline",
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ElevatedButton(
                  onPressed: () {
                    gotoScreen(
                        context: context,
                        screen: const PlayerSelectionScreen());
                  },
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                      padding: MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(
                              horizontal: Get.width / 2 - 100, vertical: 15))),
                  child: const AppText(
                    fontSize: 30,
                    text: "Play Online",
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ElevatedButton(
                  onPressed: () {
                    gotoScreen(
                        context: context,
                        screen: const JoinOnlineChessScreen());
                  },
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                      padding: MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(
                              horizontal: Get.width / 2 - 140, vertical: 15))),
                  child: const AppText(
                    fontSize: 30,
                    text: "Join Online Game",
                  )),
            )
          ]),
    );
  }
}
