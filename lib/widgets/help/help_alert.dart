import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/help.dart';
import '../../providers/help_provider.dart';
import '../components/help_select_input.dart';

import "../../utils/snackbar.dart";

class HelpAlert {
  static showHelpAlert(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder(
          future: Provider.of<HelpProvider>(
            context,
            listen: false,
          ).getHelpFrequency(),
          builder: (ct, helpSnapshot) {
            var _selectedSubject = const Help(
              name: "Sujet de la demande d'aide",
            );

            Widget buildAlert(BuildContext context) {
              if (helpSnapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                );
              }

              var help = Provider.of<HelpProvider>(
                context,
                listen: false,
              ).helpDetails;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  StatefulBuilder(builder: (
                    BuildContext context,
                    setState,
                  ) {
                    void _handleSelect(Help subject) {
                      setState(() => {_selectedSubject = subject});
                    }

                    return HelpSelectInput(
                      isValid: true,
                      handleSelect: _handleSelect,
                      selectedSubject: _selectedSubject,
                    );
                  }),
                  const SizedBox(height: 10),
                  Text(
                    "Il vous reste ${help!.counter}/${help.limit} demande(s) !",
                  ),
                ],
              );
            }

            return AlertDialog(
              title: const Center(child: Text("Demande d'aide")),
              content: buildAlert(context),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (helpSnapshot.connectionState == ConnectionState.done)
                      TextButton(
                        onPressed: () async {
                          try {
                            var response = await Provider.of<HelpProvider>(
                              context,
                              listen: false,
                            ).postHelpFrequency(_selectedSubject.name);

                            Snackbar.showScaffold(
                              response['message'],
                              response['success'],
                              context,
                            );

                            if(response['success']) Navigator.pop(context);
                          } catch (e) {
                            Snackbar.showScaffold(
                              e.toString(),
                              false,
                              context,
                            );
                          }
                        },
                        child: const Text('Valider'),
                      ),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Annuler'),
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }
}
