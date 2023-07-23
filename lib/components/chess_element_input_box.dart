import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pchess/components/app_text.dart';
import 'package:pchess/constants/element_constants.dart';
import 'package:pchess/helper/route_helper.dart';

Future<ChessElements> showChessElementSelectore(
    {required BuildContext context,
    required ElementType elementType,
    Color? bgColor}) async {
  final posibleOptions = elementType == ElementType.dark
      ? [
          ChessElementsIcons.darkCamel,
          ChessElementsIcons.darkHorse,
          ChessElementsIcons.darkElephent,
          ChessElementsIcons.darkQueen,
        ]
      : [
          ChessElementsIcons.lightCamel,
          ChessElementsIcons.lightHorse,
          ChessElementsIcons.lightElephent,
          ChessElementsIcons.lightQueen,
        ];
  final Rx<ChessElements> selectedElement = elementType == ElementType.dark
      ? ChessElements.darkCamel.obs
      : ChessElements.lightCamel.obs;

  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (dilogContext) {
      return Center(
        child: SizedBox(
          height: 360,
          width: 300,
          child: Material(
            color: bgColor,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                const SizedBox(
                  height: 3,
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: [
                      for (var option in posibleOptions)
                        InkWell(
                            onTap: () {
                              selectedElement.value =
                                  ChessElementsIcons.elementOfIcon(option);
                            },
                            child: Obx(
                              () => Container(
                                decoration: BoxDecoration(
                                  border: option ==
                                          ChessElementsIcons.iconOfElement(
                                              selectedElement.value)
                                      ? Border.all(
                                          width: 3,
                                          color: Colors.teal,
                                        )
                                      : null,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  margin: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(option))),
                                ),
                              ),
                            )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          goBack(context);
                        },
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            padding: const MaterialStatePropertyAll<EdgeInsets>(
                                EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 15))),
                        child: const AppText(
                          text: "Select",
                          fontSize: 20,
                        ))
                  ],
                )
              ]),
            ),
          ),
        ),
      );
    },
  );

  return selectedElement.value;
}
