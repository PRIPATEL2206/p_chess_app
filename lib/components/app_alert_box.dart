import 'package:flutter/material.dart';
import 'package:pchess/components/app_text.dart';

Future<bool> showAppAlertBox(
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
  bool ans = false;

  await showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: SizedBox(
          height: height,
          width: 200,
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
                            height: 50,
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
                  text: alertText,
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: AppText(
                          text: dissagreeText ?? "Cancel",
                        )),
                    ElevatedButton(
                        onPressed: () {
                          ans = true;
                          Navigator.of(context).pop();
                        },
                        child: AppText(
                          text: agreeText ?? "Ok",
                        )),
                  ],
                )
              ]),
            ),
          ),
        ),
      );
    },
  );
  return ans;
}
