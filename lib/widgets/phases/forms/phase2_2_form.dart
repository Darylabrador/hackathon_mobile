import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button_next_phase.dart';
import '../../../providers/phase_provider.dart';

import '../../components/custom_text_form_field.dart';
import '../../../utils/snackbar.dart';
import '../../../models/phase.dart';
import '../forms/phase_refresher_screen.dart';

class Phase22Form extends StatefulWidget {
  final Phase showingPhase;
  final List<dynamic>? projectData;
  const Phase22Form({
    Key? key,
    required this.showingPhase,
    this.projectData,
  }) : super(key: key);

  @override
  _Phase22FormState createState() => _Phase22FormState();
}

class _Phase22FormState extends State<Phase22Form> {
  final _formKey = GlobalKey<FormState>();
  final _produireController = TextEditingController();
  final _communiquerController = TextEditingController();
  final _delivrerController = TextEditingController();
  final _managerController = TextEditingController();

  var _isInit = true;
  var _data = {};

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _data = {
        "phaseId": widget.showingPhase.id,
        "phase": widget.showingPhase.name,
        "data": [
          {
            "produire": "",
            "communiquer": "",
            "delivrer": "",
            "manager": "",
          }
        ]
      };
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> sendData(BuildContext context) async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      _data["data"][0]["produire"] = _produireController.text.trim();
      _data["data"][0]["communiquer"] = _communiquerController.text.trim();
      _data["data"][0]["delivrer"] = _delivrerController.text.trim();
      _data["data"][0]["manager"] = _managerController.text.trim();

      final resp = await Provider.of<PhaseProvider>(
        context,
        listen: false,
      ).postPhaseData(_data);
      PhaseRefresherScreen.refreshScreen(
        context,
        resp['message'] ??
            "Bravo ! Vous avez complété l'étape 'Technologies'. Rendez-vous à l'étape suivante !",
        resp['success'],
      );
    } catch (e) {
      Snackbar.showScaffold(e.toString(), false, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            'Comment la technologie peut vous aider à mieux remplir votre mission ?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText: "Créer / Produire",
            controller: _produireController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText: "Vendre / Communiquer",
            controller: _communiquerController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText: "Servir / Délivrer",
            controller: _delivrerController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText: "Organiser / Manager",
            controller: _managerController,
          ),
          const SizedBox(height: 30),
          CustomButtonNextPhase(
            data: _data,
            completeFunction: () => sendData(context),
          ),
        ],
      ),
    );
  }
}
