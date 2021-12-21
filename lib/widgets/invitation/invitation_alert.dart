import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clipboard/clipboard.dart';
import '../../providers/invitation_provider.dart';

import "../../utils/snackbar.dart";

class InvitationAlert {
  static showAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text("Inviter un membre")),
          content: SizedBox(
            child: FutureBuilder(
              future: Provider.of<InvitationProvider>(
                context,
                listen: false,
              ).getInvitation(),
              builder: (ctx, invitSnapshot) {
                if (invitSnapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [CircularProgressIndicator()],
                  );
                }

                var invitationLink = Provider.of<InvitationProvider>(
                  context,
                ).invitationLink;

                var _loading = false;

                return StatefulBuilder(
                  builder: (BuildContext ct, setState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          invitationLink == null
                              ? ""
                              : "https://app.hackathon.run/invitation/$invitationLink",
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 17.0,
                              ),
                              child: _loading
                                  ? const CircularProgressIndicator()
                                  : TextButton(
                                      onPressed: () async {
                                        try {
                                          if (invitationLink == null) {
                                            setState(
                                              () => _loading = !_loading,
                                            );
                                            await Provider.of<
                                                InvitationProvider>(
                                              context,
                                              listen: false,
                                            ).postInvitation();
                                            setState(
                                              () => _loading = !_loading,
                                            );

                                            Snackbar.showScaffold(
                                              "Invitation générer",
                                              true,
                                              context,
                                            );
                                            Navigator.of(context).pop();
                                          } else {
                                            var link =
                                                await FlutterClipboard.copy(
                                              "https://app.hackathon.run/invitation/$invitationLink",
                                            );
                                            Snackbar.showScaffold(
                                              "Invitation copiée",
                                              true,
                                              context,
                                            );
                                            Navigator.of(context).pop();
                                          }
                                        } catch (e) {
                                          Snackbar.showScaffold(
                                            e.toString(),
                                            false,
                                            context,
                                          );
                                        }
                                      },
                                      child: Text(
                                        invitationLink == null
                                            ? 'Générer'
                                            : 'Copier',
                                      ),
                                    ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        );
      },
    );
  }
}
