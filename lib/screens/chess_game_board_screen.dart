import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pchess/components/app_text.dart';
import 'package:pchess/constants/colors_constants.dart';
import 'package:pchess/constants/element_constants.dart';
import 'package:pchess/controlers/chess_bord_controler.dart';

class ChessGameScreen extends StatelessWidget {
  const ChessGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chessBoardControler = Get.find<ChessBordControler>();
    final chessBoard = chessBoardControler.chessBoard;
    final isRotate = chessBoardControler.startOnlineChess.value &&
        chessBoardControler.isDarkPlayerJoined;
    return WillPopScope(
      onWillPop: () async {
        chessBoardControler.initateChessBord(changeValue: true);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Chess Board")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Expanded(
                child: Transform.rotate(
              angle: isRotate ? 180 : 0,
              child: GridView.count(
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                crossAxisCount: 8,
                children: [
                  for (int row = 0; row < 8; row++)
                    for (int col = 0; col < 8; col++)
                      Obx(() => InkWell(
                            onTap: () {
                              chessBoardControler.handelClickOn(
                                  element: chessBoard[row][col].value,
                                  row: row,
                                  col: col);
                            },
                            child: Container(
                              padding: EdgeInsets.all(
                                  chessBoard[row][col].value.element ==
                                              ChessElements.darkSoldure ||
                                          chessBoard[row][col].value.element ==
                                              ChessElements.lightSoldure
                                      ? 6
                                      : 2),
                              decoration: BoxDecoration(
                                // color: Colors.amber,
                                color: (row + col) % 2 == 0
                                    ? ColorsConstants.lightStile
                                    : ColorsConstants.darkStile,
                              ),
                              child: Stack(
                                children: [
                                  chessBoard[row][col].value.isInSelectedPath
                                      ? Transform.rotate(
                                          angle: 40,
                                          child: Container(
                                            margin: EdgeInsets.all(
                                                chessBoard[row][col]
                                                                .value
                                                                .element ==
                                                            ChessElements
                                                                .darkSoldure ||
                                                        chessBoard[row][col]
                                                                .value
                                                                .element ==
                                                            ChessElements
                                                                .lightSoldure
                                                    ? 10
                                                    : 13),
                                            color: Colors.blueAccent,
                                          ),
                                        )
                                      : Container(),
                                  chessBoard[row][col].value.hasElement
                                      ? Image(
                                          image: AssetImage(chessBoard[row][col]
                                              .value
                                              .elementIconUrl!))
                                      : Container(),
                                ],
                              ),
                            ),
                          ))
                ],
              ),
            )),
            Column(
              children: [
                IconButton(
                    iconSize: 30,
                    color: Colors.teal,
                    onPressed: () {
                      chessBoardControler.initateChessBord(changeValue: true);
                    },
                    icon: const Icon(CupertinoIcons.restart)),
                const AppText(
                  text: "Restart",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
