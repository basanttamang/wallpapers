import 'package:flutter/material.dart';

Widget appName() {
  return
      // return Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Image.asset(
      //       'assets/logo.png',
      //       height: 100,
      //       width: 100,
      //     ),
      RichText(
    text: const TextSpan(
      children: <TextSpan>[
        TextSpan(
            text: 'Korean',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
              fontSize: 20,
            )),
        TextSpan(
            text: ' Wallpaper',
            style: TextStyle(fontSize: 20, fontFamily: 'Poppins')),
      ],
    ),
  );
  //   ],
  // );
}
