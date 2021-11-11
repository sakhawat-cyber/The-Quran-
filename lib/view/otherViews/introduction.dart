import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';

class OnBoardingCard extends StatelessWidget {

  final pages = [
    PageModel(
        color: Colors.grey[700],
        imageAssetPath: "assets/grad_logo.png",
        title: "They Holy Qur'an",
        body:
            "\"Indeed,It is We sent down the Quran and indeed, We will be its Guardian\"\n",
        doAnimateImage: true),
    PageModel(
        color: const Color(0xff106791),
        imageAssetPath: 'assets/ui.png',
        title: "Fancy & Beautiful Design",
        body:"We have Worked hard to choose Beautiful Colors, animation and overall an appealing Design for this Beautiful Book",
        doAnimateImage: true),
    PageModel(
        color: Colors.grey[750],
        imageAssetPath: "assets/sajdaIndex.png",
        title: "Sajda Index",
        body: "Now, with Sajda Index you can directly open any Sajda in Qur'an from the list along with brief information about it.",
    doAnimateImage: true
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          Navigator.pushNamed(context, '/HomeScreen');
        },
        finishCallback: () {
          Navigator.pushNamed(context, '/HomeScreen');

        },
      ),
    );
  }
}
