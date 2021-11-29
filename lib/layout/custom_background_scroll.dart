import 'package:flutter/material.dart';

class CustomBackgroundScroll extends StatelessWidget {
  final Widget? ch;
  const CustomBackgroundScroll({Key? key, this.ch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            deviceOrientation == Orientation.landscape
                ? "assets/images/background_landscape.png"
                : "assets/images/background.png",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: ch,
      ),
    );
  }
}
