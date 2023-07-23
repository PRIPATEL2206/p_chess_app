import 'package:flutter/material.dart';
import 'package:pchess/components/app_text.dart';

Future<bool?> showAppAlertBox(
  BuildContext context, {
  double height = 80,
  required String alertText,
  ImageProvider? image,
  Color? alertIconBGColor,
  String? dissagreeText,
  String? agreeText,
  BorderRadius? borderRadius,
  Color? bgColor,
}) async {
  bool? ans;

  await showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: SizedBox(
          height: height,
          width: 300,
          child: Material(
            color: bgColor,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                const SizedBox(
                  height: 3,
                ),
                Container(
                    padding: const EdgeInsets.all(4).copyWith(bottom: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: alertIconBGColor,
                      shape: BoxShape.circle,
                    ),
                    child: image != null
                        ? Image(
                            height: 100,
                            image: image,
                          )
                        : const Icon(
                            Icons.info_outline,
                            color: Colors.amber,
                          )),
                const SizedBox(
                  height: 5,
                ),
                AppText(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  text: alertText,
                ),
                const SizedBox(
                  height: 20,
                ),
                dissagreeText != null
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            padding: const MaterialStatePropertyAll<EdgeInsets>(
                                EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 15))),
                        child: AppText(
                          text: dissagreeText,
                          fontSize: 20,
                        ))
                    : Container(),
                const SizedBox(
                  height: 15,
                ),
                agreeText != null
                    ? ElevatedButton(
                        onPressed: () {
                          ans = true;
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            padding: const MaterialStatePropertyAll<EdgeInsets>(
                                EdgeInsets.symmetric(
                                    horizontal: 60, vertical: 15))),
                        child: AppText(
                          text: agreeText,
                          fontSize: 20,
                        ))
                    : Container()
              ]),
            ),
          ),
        ),
      );
    },
  );
  return ans;
}
