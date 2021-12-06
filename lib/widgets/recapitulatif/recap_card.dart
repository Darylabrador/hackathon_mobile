import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/recap_provider.dart';

import './recap_card_content.dart';
import '../components/custom_card.dart';
import '../../services/error_service.dart';

class RecapCard extends StatelessWidget {
  const RecapCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final data = Provider.of<RecapProvider>(context).recapData;

    if (data!.isEmpty) {
      return ErrorService.showError("Données indisponible");
    }

    return ListView.builder(
      padding: const EdgeInsets.all(5.0),
      itemCount: data.length,
      itemBuilder: (ctx, index) => Column(
        children: [
          const SizedBox(height: 10),
          CustomCard(
            width: mediaQuery.size.width * 0.9,
            title: data[index]["phase"],
            cardWidget: RecapCardContent(phaseData: data[index]["data"]),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
