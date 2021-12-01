import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final dynamic width;
  final String title;
  final Widget cardWidget;

  const CustomCard({
    Key? key,
    required this.width,
    required this.title,
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
            Text(
              title,
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 8),
            const Divider(color: Colors.black26),
            const SizedBox(height: 8),
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
