import 'package:flutter/material.dart';

class CustomCardSimple extends StatelessWidget {
  final dynamic width;
  final Widget cardWidget;

  const CustomCardSimple({
    Key? key,
    required this.width,
    required this.cardWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: const BorderSide(
          color: Colors.black26,
          width: 1.0,
        ),
      ),
      elevation: 5,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: cardWidget,
            ),
          ],
        ),
      ),
    );
  }
}
