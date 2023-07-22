import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pchess/components/app_text.dart';
import 'package:pchess/constants/element_constants.dart';

Future<ChessElements> showChessElementSelectore(
    {required BuildContext context,
    required ElementType elementType,
    Color? bgColor}) async {
  final Rx<ChessElements?> selectedElement = null.obs;
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

  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (dilogContext) {
      return Center(
        child: SizedBox(
          height: 330,
          width: 300,
          child: Material(
            color: bgColor,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                const SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    for (var option in posibleOptions)
                      InkWell(
                        onTap: () {
                          selectedElement.value =
                              ChessElementsIcons.elementOfIcon(option);
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          padding: const EdgeInsets.all(.3),
                          decoration: BoxDecoration(
                              border: (selectedElement.value != null &&
                                      option ==
                                          ChessElementsIcons.iconOfElement(
                                              selectedElement.value!))
                                  ? Border.all(
                                      width: 1,
                                      color: Colors.teal,
                                    )
                                  : null,
                              borderRadius: BorderRadius.circular(5),
                              image:
                                  DecorationImage(image: AssetImage(option))),
                          margin: const EdgeInsets.all(6),
                        ),
                      )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (selectedElement.value != null) {
                            Navigator.of(dilogContext).pop();
                          }
                        },
                        child: const AppText(text: "Select"))
                  ],
                )
              ]),
            ),
          ),
        ),
      );
    },
  );

  return selectedElement.value!;
}
