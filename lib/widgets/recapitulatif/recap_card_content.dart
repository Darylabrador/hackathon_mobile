import 'package:flutter/material.dart';

class RecapCardContent extends StatelessWidget {
  final List<dynamic> phaseData;
  const RecapCardContent({
    Key? key,
    required this.phaseData,
  }) : super(key: key);

  List<Widget> get cardContent {
    var widgetList = <Widget>[];
    if (phaseData.isEmpty) return widgetList;

    for (var element in phaseData) {
      var data = element as Map<String, dynamic>;
      data.forEach(
        (key, value) {
          widgetList.add(
            SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        key.toString().toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(value.toString()),
                      const SizedBox(height: 5),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    }
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [...cardContent],
    );
  }
}
