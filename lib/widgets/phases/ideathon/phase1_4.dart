import 'package:flutter/material.dart';
import '../../../models/phase.dart';

import '../../components/custom_card_simple.dart';
import '../forms/phase1_4_form.dart';

class Phase14 extends StatefulWidget {
  static const fileName = "phase1_4";
  final Phase showingPhase;
  final List<dynamic>? projectData;

  const Phase14({
    Key? key,
    this.projectData,
    required this.showingPhase,
  }) : super(key: key);

  @override
  State<Phase14> createState() => _Phase14State();
}

class _Phase14State extends State<Phase14> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Column(
      children: [
        const SizedBox(height: 50),
        Text(
          "Votre différence",
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
          cardWidget: Phase14Form(
            showingPhase: widget.showingPhase,
            projectData: widget.projectData,
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
