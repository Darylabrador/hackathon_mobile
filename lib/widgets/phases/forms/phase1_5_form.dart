import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../../components/custom_button_next_phase.dart';
import '../../../providers/phase_provider.dart';

import '../../components/custom_text_form_field.dart';
import '../../../utils/snackbar.dart';
import '../../../models/phase.dart';
import '../forms/phase_refresher_screen.dart';

class Phase15Form extends StatefulWidget {
  final Phase showingPhase;
  final List<dynamic>? projectData;

  const Phase15Form({
    Key? key,
    this.projectData,
    required this.showingPhase,
  }) : super(key: key);

  @override
  _Phase15FormState createState() => _Phase15FormState();
}

class _Phase15FormState extends State<Phase15Form> {
  final _formKey = GlobalKey<FormState>();
  final _penseController = TextEditingController();
  final _ressentController = TextEditingController();
  final _ditController = TextEditingController();
  final _faitController = TextEditingController();

  var _isInit = true;
  var _data = {};

  var _displayPenseLabel = false;
  var _displayRessentLabel = false;
  var _displayDitLabel = false;
  var _displayFaitLabel = false;

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
            "pense": saved == null ? "" : saved["pense"],
            "ressent": saved == null ? "" : saved["ressent"],
            "dit": saved == null ? "" : saved["dit"],
            "fait": saved == null ? "" : saved["fait"],
          }
        ]
      };

      _penseController.text = saved == null ? "" : saved["pense"];
      _ressentController.text = saved == null ? "" : saved["ressent"];
      _ditController.text = saved == null ? "" : saved["dit"];
      _faitController.text = saved == null ? "" : saved["fait"];

      onChangePenseValue(saved == null ? null : saved["pense"]);
      onChangeRessentValue(saved == null ? null : saved["ressent"]);
      onChangeDitValue(saved == null ? null : saved["dit"]);
      onChangeFaitValue(saved == null ? null : saved["fait"]);
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
      _data["data"][0]["pense"] = _penseController.text.trim();
      _data["data"][0]["ressent"] = _ressentController.text.trim();
      _data["data"][0]["dit"] = _ditController.text.trim();
      _data["data"][0]["fait"] = _faitController.text.trim();

      final resp = await Provider.of<PhaseProvider>(
        context,
        listen: false,
      ).postPhaseData(_data);
      PhaseRefresherScreen.refreshScreen(
        context,
        resp['message'] ??
            "Bravo ! Vous avez complété l'étape 'dans la tête de vos utilisateurs'. Rendez-vous à l'étape suivante !",
        resp['success'],
      );
    } catch (e) {
      Snackbar.showScaffold(e.toString(), false, context);
    }
  }

  void onChangePenseValue(String? value) {
    if (value == null || value == "") {
      setState(() {
        _displayPenseLabel = false;
      });
    } else {
      setState(() {
        _displayPenseLabel = true;
      });
    }
  }

  void onChangeRessentValue(String? value) {
    if (value == null || value == "") {
      setState(() {
        _displayRessentLabel = false;
      });
    } else {
      setState(() {
        _displayRessentLabel = true;
      });
    }
  }

  void onChangeDitValue(String? value) {
    if (value == null || value == "") {
      setState(() {
        _displayDitLabel = false;
      });
    } else {
      setState(() {
        _displayDitLabel = true;
      });
    }
  }

  void onChangeFaitValue(String? value) {
    if (value == null || value == "") {
      setState(() {
        _displayFaitLabel = false;
      });
    } else {
      setState(() {
        _displayFaitLabel = true;
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
            labelText: _displayPenseLabel ? "Ce qu'il pense" : null,
            minLines: 5,
            maxLines: 10,
            hintText: "Ce qu'il pense",
            controller: _penseController,
            onChanged: (value) => onChangePenseValue(value),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            labelText: _displayRessentLabel ? "Ce qu'il ressent" : null,
            minLines: 5,
            maxLines: 10,
            hintText: "Ce qu'il ressent",
            controller: _ressentController,
            onChanged: (value) => onChangeRessentValue(value),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            labelText: _displayDitLabel ? "Ce qu'il dit" : null,
            minLines: 5,
            maxLines: 10,
            hintText: "Ce qu'il dit",
            controller: _ditController,
            onChanged: (value) => onChangeDitValue(value),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            labelText: _displayFaitLabel ? "Ce qu'il fait" : null,
            minLines: 5,
            maxLines: 10,
            hintText: "Ce qu'il fait",
            controller: _faitController,
            onChanged: (value) => onChangeFaitValue(value),
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
