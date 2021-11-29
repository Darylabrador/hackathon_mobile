import 'package:flutter/material.dart';

class CustomBackgroundScroll extends StatelessWidget {
  final Widget? ch;
  const CustomBackgroundScroll({Key? key, this.ch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: ch,
      ),
    );
  }
}
