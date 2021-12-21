import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.isRecruitement)
              ElevatedButton(
                onPressed: () => InvitationAlert.showAlert(context),
                child: const Text('Inviter'),
              ),
            if (widget.isRecruitement) const SizedBox(width: 20),
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
