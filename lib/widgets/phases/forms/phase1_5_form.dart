import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button_next_phase.dart';
import '../../../providers/phase_provider.dart';

import '../../components/custom_text_form_field.dart';
import '../../../services/validator_service.dart';
import '../../../utils/snackbar.dart';
import '../../../models/phase.dart';
import '../forms/phase_refresher_screen.dart';

class Phase15Form extends StatefulWidget {
  final Phase showingPhase;
  final List<dynamic>? projectData;
  const Phase15Form({
    Key? key,
    required this.showingPhase,
    this.projectData,
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

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _data = {
        "phaseId": widget.showingPhase.id,
        "phase": widget.showingPhase.name,
        "data": [
          {
            "pense": "",
            "ressent": "",
            "dit": "",
            "fait": "",
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            minLines: 5,
            maxLines: 10,
            hintText: "Ce qu'il pense",
            controller: _penseController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 10,
            hintText: "Ce qu'il ressent",
            controller: _ressentController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 10,
            hintText: "Ce qu'il dit",
            controller: _ditController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 10,
            hintText: "Ce qu'il fait",
            controller: _faitController,
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
