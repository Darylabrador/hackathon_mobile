import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../../components/custom_button_next_phase.dart';
import '../../../providers/phase_provider.dart';

import '../../components/custom_text_form_field.dart';
import '../../../utils/snackbar.dart';
import '../../../models/phase.dart';
import '../forms/phase_refresher_screen.dart';

class Phase23Form extends StatefulWidget {
  final Phase showingPhase;
  final List<dynamic>? projectData;

  const Phase23Form({
    Key? key,
    this.projectData,
    required this.showingPhase,
  }) : super(key: key);

  @override
  _Phase23FormState createState() => _Phase23FormState();
}

class _Phase23FormState extends State<Phase23Form> {
  final _formKey = GlobalKey<FormState>();
  final _missionController = TextEditingController();
  final _valeursController = TextEditingController();
  final _sloganController = TextEditingController();
  final _ambassadeurController = TextEditingController();

  var _isInit = true;
  var _data = {};

  @override
  void didChangeDependencies() {
    if (_isInit) {
      var saved = widget.projectData!.firstWhereOrNull(
        (element) => element['phaseId'] == widget.showingPhase.id,
      );

      _data = {
        "phaseId": widget.showingPhase.id,
        "phase": widget.showingPhase.name,
        "data": [
          {
            "mission": saved == null ? "" : saved["mission"],
            "valeurs": saved == null ? "" : saved["valeurs"],
            "slogan": saved == null ? "" : saved["slogan"],
            "ambassadeur": saved == null ? "" : saved["ambassadeur"],
          }
        ]
      };

      _missionController.text = saved == null ? "" : saved["mission"];
      _valeursController.text = saved == null ? "" : saved["valeurs"];
      _sloganController.text = saved == null ? "" : saved["slogan"];
      _ambassadeurController.text = saved == null ? "" : saved["ambassadeur"];
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
      _data["data"][0]["mission"] = _missionController.text.trim();
      _data["data"][0]["valeurs"] = _valeursController.text.trim();
      _data["data"][0]["slogan"] = _sloganController.text.trim();
      _data["data"][0]["ambassadeur"] = _ambassadeurController.text.trim();

      final resp = await Provider.of<PhaseProvider>(
        context,
        listen: false,
      ).postPhaseData(_data);
      PhaseRefresherScreen.refreshScreen(
        context,
        resp['message'] ??
            "Bravo ! Vous avez défini votre marque. Rendez-vous à l'étape suivante !",
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
            'Que représente votre marque ?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText: "Votre mission : que voulez-vous permettre ?",
            controller: _missionController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText:
                "Quelles sont les 3 valeurs les plus importantes pour vous ?",
            controller: _valeursController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText: "Quel est son nom, son slogan ?",
            controller: _sloganController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText:
                "Comment pouvez-vous transformer vos clients en ambassadeurs ?",
            controller: _ambassadeurController,
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
