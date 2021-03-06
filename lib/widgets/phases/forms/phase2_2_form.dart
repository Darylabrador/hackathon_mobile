import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

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
    this.projectData,
    required this.showingPhase,
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

  var _displayProduireLabel = false;
  var _displayCommuniquerLabel = false;
  var _displayDelivrerLabel = false;
  var _displayManagerLabel = false;

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
            "produire": saved == null ? "" : saved["produire"],
            "communiquer": saved == null ? "" : saved["communiquer"],
            "delivrer": saved == null ? "" : saved["delivrer"],
            "manager": saved == null ? "" : saved["manager"],
          }
        ]
      };

      _produireController.text = saved == null ? "" : saved["produire"];
      _communiquerController.text = saved == null ? "" : saved["communiquer"];
      _delivrerController.text = saved == null ? "" : saved["delivrer"];
      _managerController.text = saved == null ? "" : saved["manager"];

      onChangeProduireValue(saved == null ? null : saved["produire"]);
      onChangeCommuniquerValue(saved == null ? null : saved["communiquer"]);
      onChangeDelivrerValue(saved == null ? null : saved["delivrer"]);
      onChangeManagerValue(saved == null ? null : saved["manager"]);
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
            "Bravo ! Vous avez compl??t?? l'??tape 'Technologies'. Rendez-vous ?? l'??tape suivante !",
        resp['success'],
      );
    } catch (e) {
      Snackbar.showScaffold(e.toString(), false, context);
    }
  }

  void onChangeProduireValue(String? value) {
    if (value == null || value == "") {
      setState(() {
        _displayProduireLabel = false;
      });
    } else {
      setState(() {
        _displayProduireLabel = true;
      });
    }
  }

  void onChangeCommuniquerValue(String? value) {
    if (value == null || value == "") {
      setState(() {
        _displayCommuniquerLabel = false;
      });
    } else {
      setState(() {
        _displayCommuniquerLabel = true;
      });
    }
  }

  void onChangeDelivrerValue(String? value) {
    if (value == null || value == "") {
      setState(() {
        _displayDelivrerLabel = false;
      });
    } else {
      setState(() {
        _displayDelivrerLabel = true;
      });
    }
  }

  void onChangeManagerValue(String? value) {
    if (value == null || value == "") {
      setState(() {
        _displayManagerLabel = false;
      });
    } else {
      setState(() {
        _displayManagerLabel = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            'Comment la technologie peut vous aider ?? mieux remplir votre mission ?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            labelText: _displayProduireLabel ? "Cr??er / Produire" : null,
            minLines: 5,
            maxLines: 15,
            hintText: "Cr??er / Produire",
            controller: _produireController,
            onChanged: (value) => onChangeProduireValue(value),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            labelText: _displayCommuniquerLabel ? "Vendre / Communiquer" : null,
            minLines: 5,
            maxLines: 15,
            hintText: "Vendre / Communiquer",
            controller: _communiquerController,
            onChanged: (value) => onChangeCommuniquerValue(value),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            labelText: _displayDelivrerLabel ? "Servir / D??livrer" : null,
            minLines: 5,
            maxLines: 15,
            hintText: "Servir / D??livrer",
            controller: _delivrerController,
            onChanged: (value) => onChangeDelivrerValue(value),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            labelText: _displayManagerLabel ? "Organiser / Manager" : null,
            minLines: 5,
            maxLines: 15,
            hintText: "Organiser / Manager",
            controller: _managerController,
            onChanged: (value) => onChangeManagerValue(value),
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
