import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../utils/utilities.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;
  const ImageView({Key? key, required this.imgUrl}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imgUrl,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton(
                  onPressed: () async {
                    await setWallpaper(context: context, url: widget.imgUrl);
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xff1C1B1B).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(30)),
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(colors: [
                              Color(0x36FFFFFF),
                              Color(0x0FFFFFFF)
                            ])),
                        child: Column(
                          children: const [
                            Text(
                              "Set as Wallpaper",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                            Text("It will be set automatically",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white70,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xff1C1B1B).withOpacity(0.8),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

//   _showDialog(BuildContext context) {
//     showCupertinoModalPopup(
//         context: context,
//         builder: (context) {
//           return CupertinoActionSheet(
//             title: const Text("Set as"),
//             actions: [
//               CupertinoActionSheetAction(
//                   onPressed: () {}, child: const Text("Home Screen")),
//               CupertinoActionSheetAction(
//                   onPressed: () {}, child: const Text("Lock Screen")),
//               CupertinoActionSheetAction(
//                   onPressed: () {}, child: const Text("Both Screen"))
//             ],
//           );
//         });
//   }
// }
}
