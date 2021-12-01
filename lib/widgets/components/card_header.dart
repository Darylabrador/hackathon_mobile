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
        const SizedBox(height: 10),
        const SizedBox(
          width: 290.0,
          child: Divider(
            height: 1,
            thickness: 2,
            color: Colors.black26,
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
