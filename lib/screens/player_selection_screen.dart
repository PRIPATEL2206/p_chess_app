import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pchess/components/app_text.dart';
import 'package:pchess/constants/element_constants.dart';
import 'package:pchess/controlers/chess_bord_controler.dart';
import 'package:pchess/helper/route_helper.dart';
import 'package:pchess/screens/id_share_screen.dart';

class PlayerSelectionScreen extends StatelessWidget {
  const PlayerSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Rx<ElementType> selectedElement = ElementType.light.obs;
    final Rx<bool> isLoding = false.obs;

    return Scaffold(
      appBar: AppBar(
          title: const AppText(
        text: "Select Player",
      )),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
                onTap: () {
                  selectedElement.value = ElementType.light;
                },
                child: Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      border: selectedElement.value == ElementType.light
                          ? Border.all(width: 3, color: Colors.teal)
                          : null,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(ChessElementsIcons.lightKing)),
                      ),
                    ),
                  ),
                )),
            InkWell(
                onTap: () {
                  selectedElement.value = ElementType.dark;
                },
                child: Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      border: selectedElement.value == ElementType.dark
                          ? Border.all(width: 3, color: Colors.teal)
                          : null,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(ChessElementsIcons.darkKing)),
                      ),
                    ),
                  ),
                )),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Obx(
          () => ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
                padding: MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(
                        horizontal: Get.width / 2 - 100, vertical: 15))),
            onPressed: () {
              isLoding.value = true;
              Get.find<ChessBordControler>()
                  .createChessRoom(joinAs: selectedElement.value)
                  .then((chessBoardId) {
                if (chessBoardId != null) {
                  replaceScreen(
                      context: context,
                      screen: IdSharingScreen(chessBoardId: chessBoardId));
                }
              });
            },
            child: isLoding.value
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const AppText(
                    fontSize: 30,
                    text: "Play",
                  ),
          ),
        ),
      ]),
    );
  }
}
