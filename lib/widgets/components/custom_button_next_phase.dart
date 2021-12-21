import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../invitation/invitation_alert.dart';

class CustomButtonNextPhase extends StatefulWidget {
  final bool isRecruitement;
  const CustomButtonNextPhase({
    Key? key,
    this.isRecruitement = false,
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

  @override
  Widget build(BuildContext context) {
    var userRole = Provider.of<AuthProvider>(context).role;

    return Column(
      children: [
        const SizedBox(height: 20),
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
              onPressed: () {},
              child: const Text('Suivant'),
            ),
          ],
        )
      ],
    );
  }
}
