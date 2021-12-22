import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../../components/custom_button_next_phase.dart';
import '../../../providers/phase_provider.dart';

import '../../components/custom_text_form_field.dart';
import '../../../services/validator_service.dart';
import '../../../utils/snackbar.dart';
import '../../../models/phase.dart';
import '../forms/phase_refresher_screen.dart';

class Phase12Form extends StatefulWidget {
  final Phase showingPhase;
  final List<dynamic>? projectData;

  const Phase12Form({
    Key? key,
    this.projectData,
    required this.showingPhase,
  }) : super(key: key);

  @override
  _Phase12FormState createState() => _Phase12FormState();
}

class _Phase12FormState extends State<Phase12Form> {
  final _formKey = GlobalKey<FormState>();
  final _quoiController = TextEditingController();

  var _isInit = true;
  var _data = {};

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      var saved = widget.projectData!.firstWhereOrNull(
        (element) => element['phaseId'] == widget.showingPhase.id,
      );

      _data = {
        "phaseId": widget.showingPhase.id,
        "phase": widget.showingPhase.name,
        "data": [
          {
            "quoi": saved == null ? "" : saved["quoi"],
          }
        ]
      };

      _quoiController.text = saved == null ? "" : saved["quoi"];
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
      _data["data"][0]["quoi"] = _quoiController.text.trim();
      final resp = await Provider.of<PhaseProvider>(
        context,
        listen: false,
      ).postPhaseData(_data);
      PhaseRefresherScreen.refreshScreen(
        context,
        resp['message'] ??
            "Bravo ! Vous avez finalisé la présentation de votre idée pour l'Idéathon Alternatives au cash.",
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
            maxLines: 50,
            hintText:
                "Détaillez votre offre avec des mots simples et clairs, comme par exemple : « Ce mini-guide de questions vous permet de construire une présentation détaillée de votre projet. il est composé de 3 phases clés amenant à une présentation finale idéale pour convaincre.",
            controller: _quoiController,
            validator: (value) => ValidatorService.validateField(value),
          ),
          CustomButtonNextPhase(
            data: _data,
            completeFunction: () => sendData(context),
          ),
        ],
      ),
    );
  }
}
