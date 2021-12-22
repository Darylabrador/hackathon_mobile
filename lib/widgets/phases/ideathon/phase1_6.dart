import 'package:flutter/material.dart';
import '../../../models/phase.dart';

import '../../components/custom_card_simple.dart';
import '../forms/phase1_6_form.dart';

class Phase16 extends StatefulWidget {
  static const fileName = "phase1_6";
  final Phase showingPhase;
  final List<dynamic>? projectData;

  const Phase16({
    Key? key,
    this.projectData,
    required this.showingPhase,
  }) : super(key: key);

  @override
  State<Phase16> createState() => _Phase16State();
}

class _Phase16State extends State<Phase16> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Column(
      children: [
        const SizedBox(height: 50),
        Text(
          "Votre proposition de valeur",
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
          cardWidget: Phase16Form(
            showingPhase: widget.showingPhase,
            projectData: widget.projectData,
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
