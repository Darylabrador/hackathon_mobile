import 'package:flutter/material.dart';
import '../../../models/phase.dart';

import '../../components/custom_card_simple.dart';
import '../forms/phase2_1_form.dart';

class Phase21 extends StatefulWidget {
  static const fileName = "phase2_1";
  final Phase showingPhase;
  final List<dynamic>? projectData;

  const Phase21({
    Key? key,
    this.projectData,
    required this.showingPhase,
  }) : super(key: key);

  @override
  State<Phase21> createState() => _Phase21State();
}

class _Phase21State extends State<Phase21> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Column(
      children: [
        const SizedBox(height: 50),
        Text(
          "Parties prenantes",
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: 40),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "Attention lorsque vous avez validé la phase, vous ne pouvez plus faire marche arrière !",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(height: 20),
        CustomCardSimple(
          width: mediaQuery.size.width * 0.9,
          cardWidget: Phase21Form(
            showingPhase: widget.showingPhase,
            projectData: widget.projectData,
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
