import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pchess/constants/colors_constants.dart';
import 'package:pchess/controlers/chess_bord_controler.dart';

class ChessGameScreen extends StatelessWidget {
  const ChessGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chessBoardControler = Get.find<ChessBordControler>();
    final chessBoard = chessBoardControler.chessBoard;
    return WillPopScope(
      onWillPop: () async {
        chessBoardControler.initateChessBord();
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
                            padding: const EdgeInsets.all(5),
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
                                          margin: const EdgeInsets.all(10),
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
            ))
          ],
        ),
      ),
    );
  }
}
