import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../../components/custom_button_next_phase.dart';
import '../../../providers/phase_provider.dart';

import '../../components/custom_text_form_field.dart';
import '../../../utils/snackbar.dart';
import '../../../models/phase.dart';
import '../forms/phase_refresher_screen.dart';

class Phase16Form extends StatefulWidget {
  final Phase showingPhase;
  final List<dynamic>? projectData;

  const Phase16Form({
    Key? key,
    this.projectData,
    required this.showingPhase,
  }) : super(key: key);

  @override
  _Phase16FormState createState() => _Phase16FormState();
}

class _Phase16FormState extends State<Phase16Form> {
  final _formKey = GlobalKey<FormState>();
  final _contenuController = TextEditingController();

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
          {"contenu": saved == null ? "" : saved["contenu"]}
        ]
      };

      _contenuController.text = saved == null ? "" : saved["contenu"];
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
      _data["data"][0]["contenu"] = _contenuController.text.trim();

      final resp = await Provider.of<PhaseProvider>(
        context,
        listen: false,
      ).postPhaseData(_data);
      PhaseRefresherScreen.refreshScreen(
        context,
        resp['message'] ??
            "Bravo ! Vous avez défini la proposition de valeur de votre offre ou produit. Rendez-vous à l'étape suivante !",
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
            'Indication :',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Notre ……………….. permet de ……………….. afin de répondre au problème de …………………….. en utilisant ………………………… afin d‘aider/soutenir les ……………….( utilisateurs ) mieux que …………………… qu’ils utilisent aujourd’hui. ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 50),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText:
                "Qu’apportez-vous de mieux, que permettez-vous à vos utilisateurs ?",
            controller: _contenuController,
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
