import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final double width;
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
      elevation: 5,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 5),
            Text(
              title,
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 5),
            const Divider(),
            cardWidget,
          ],
        ),
      ),
    );
  }
}
