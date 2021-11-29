import 'package:flutter/material.dart';

class CardHeader {
  static Column content({
    required BuildContext context,
    required MediaQueryData mediaQuery,
    required SizedBox topSpace,
  }) {
    return Column(
      children: [
        topSpace,
        Text(
          "Hackathon",
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(
          "Alternatives au cash",
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(
          width: 250.0,
          child: Divider(),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
