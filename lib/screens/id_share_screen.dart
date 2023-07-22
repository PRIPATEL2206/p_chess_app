import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pchess/components/app_text.dart';
import 'package:pchess/controlers/chess_bord_controler.dart';
import 'package:pchess/helper/route_helper.dart';
import 'package:pchess/screens/chess_game_board_screen.dart';

class IdSharingScreen extends StatelessWidget {
  final String chessBoardId;
  const IdSharingScreen({super.key, required this.chessBoardId});

  @override
  Widget build(BuildContext context) {
    Get.find<ChessBordControler>().startOnlineChess.listen(
      (e) {
        if (e) {
          replaceScreen(context: context, screen: const ChessGameScreen());
        }
      },
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const AppText(
            text: "Share with your friend",
            fontSize: 25,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: Get.width - 100,
                decoration: BoxDecoration(border: Border.all()),
                child: SelectableText(
                  style: const TextStyle(fontSize: 20),
                  chessBoardId,
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: chessBoardId));
                  },
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: chessBoardId));
                    Get.snackbar("Copied", chessBoardId);
                  },
                  icon: const Icon(Icons.copy))
            ],
          )
        ]),
      ),
    );
  }
}
