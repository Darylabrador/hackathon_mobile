import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

import '../../providers/auth_provider.dart';
import '../invitation/invitation_alert.dart';
import '../../screens/dashboard_screen.dart';
import '../../utils/snackbar.dart';

class CustomButtonNextPhase extends StatefulWidget {
  final bool isRecruitement;
  final bool isComplete;
  final Function completeFunction;
  final String completeMessage;
  final Map<dynamic, dynamic> data;

  const CustomButtonNextPhase({
    Key? key,
    this.isRecruitement = false,
    this.isComplete = false,
    this.completeMessage = "",
    required this.completeFunction,
    required this.data,
  }) : super(key: key);

  @override
  _CustomButtonNextPhaseState createState() => _CustomButtonNextPhaseState();
}

class _CustomButtonNextPhaseState extends State<CustomButtonNextPhase> {
  bool isAuthorize(String userRole) {
    final roles = ['porteur de projet', 'chef de projet', 'chef equipe'];
    if (roles.contains(userRole)) {
      return true;
    } else {
      return false;
    }
  }

  var _loading = false;

  @override
  Widget build(BuildContext context) {
    var userRole = Provider.of<AuthProvider>(context).role;

    return Column(
      children: [
        const SizedBox(height: 20),
        if (_loading) const Center(child: CircularProgressIndicator()),
        if (!_loading)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isRecruitement && isAuthorize(userRole!))
                ElevatedButton(
                  onPressed: () => InvitationAlert.showAlert(context),
                  child: const Text('Inviter'),
                ),
              if (widget.isRecruitement && isAuthorize(userRole!))
                const SizedBox(width: 20),
              ElevatedButton(
                onPressed: widget.isComplete
                    ? null
                    : () async {
                        setState(() {
                          _loading = !_loading;
                        });
                        try {
                          final resp = await widget.completeFunction(
                            widget.data,
                          );
                          Snackbar.showScaffold(
                            resp['message'] ?? widget.completeMessage,
                            resp['success'],
                            context,
                          );
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: const DashboardScreen(),
                            ),
                          );
                        } catch (e) {
                          Snackbar.showScaffold(
                            e.toString(),
                            false,
                            context,
                          );
                        }
                        setState(() {
                          _loading = !_loading;
                        });
                      },
                child: const Text('Suivant'),
              ),
            ],
          )
      ],
    );
  }
}
