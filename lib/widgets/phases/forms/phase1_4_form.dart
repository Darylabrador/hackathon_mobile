import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../../components/custom_button_next_phase.dart';
import '../../../providers/phase_provider.dart';

import '../../components/custom_text_form_field.dart';
import '../../../utils/snackbar.dart';
import '../../../models/phase.dart';
import '../forms/phase_refresher_screen.dart';

class Phase14Form extends StatefulWidget {
  final Phase showingPhase;
  final List<dynamic>? projectData;

  const Phase14Form({
    Key? key,
    this.projectData,
    required this.showingPhase,
  }) : super(key: key);

  @override
  _Phase14FormState createState() => _Phase14FormState();
}

class _Phase14FormState extends State<Phase14Form> {
  final _formKey = GlobalKey<FormState>();
  final _explicationController = TextEditingController();
  final _chiffrageController = TextEditingController();

  var _isInit = true;
  var _data = {};

  var _displayExplicationLabel = false;
  var _displayChiffrageLabel = false;

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
            "explication": saved == null ? "" : saved["explication"],
            "chiffrage": saved == null ? "" : saved["chiffrage"],
          }
        ]
      };

      _explicationController.text = saved == null ? "" : saved["explication"];
      _chiffrageController.text = saved == null ? "" : saved["chiffrage"];
      onChangeExplicationValue(saved == null ? null : saved["explication"]);
      onChangeChiffrageValue(saved == null ? null : saved["chiffrage"]);
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
      _data["data"][0]["explication"] = _explicationController.text.trim();
      _data["data"][0]["chiffrage"] = _chiffrageController.text.trim();

      final resp = await Provider.of<PhaseProvider>(
        context,
        listen: false,
      ).postPhaseData(_data);
      PhaseRefresherScreen.refreshScreen(
        context,
        resp['message'] ??
            "Bravo ! Vous avez identifié le(s) facteur(s) de différenciation de votre offre. Rendez-vous à l'étape suivante !",
        resp['success'],
      );
    } catch (e) {
      Snackbar.showScaffold(e.toString(), false, context);
    }
  }

  void onChangeExplicationValue(String? value) {
    if (value == null || value == "") {
      setState(() {
        _displayExplicationLabel = false;
      });
    } else {
      setState(() {
        _displayExplicationLabel = true;
      });
    }
  }

  void onChangeChiffrageValue(String? value) {
    if (value == null || value == "") {
      setState(() {
        _displayChiffrageLabel = false;
      });
    } else {
      setState(() {
        _displayChiffrageLabel = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            labelText: _displayExplicationLabel
                ? "Expliquer en quoi vos solutions amènent un mieux"
                : null,
            minLines: 5,
            maxLines: 10,
            hintText:
                "Pouvez-vous expliquer en quoi vos solutions amènent un mieux, une innovation ?",
            controller: _explicationController,
            onChanged: (value) => onChangeExplicationValue(value),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            labelText: _displayChiffrageLabel
                ? "Pouvez-vous chiffrer votre avantage ?"
                : null,
            minLines: 5,
            maxLines: 10,
            hintText: "Pouvez-vous chiffrer votre avantage ? Euro, minutes, %…",
            controller: _chiffrageController,
            onChanged: (value) => onChangeChiffrageValue(value),
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
