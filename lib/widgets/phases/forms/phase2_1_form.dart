import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button_next_phase.dart';
import '../../../providers/phase_provider.dart';

import '../../components/custom_text_form_field.dart';
import '../../../utils/snackbar.dart';
import '../../../models/phase.dart';
import '../forms/phase_refresher_screen.dart';

class Phase21Form extends StatefulWidget {
  final Phase showingPhase;
  final List<dynamic>? projectData;
  const Phase21Form({
    Key? key,
    required this.showingPhase,
    this.projectData,
  }) : super(key: key);

  @override
  _Phase21FormState createState() => _Phase21FormState();
}

class _Phase21FormState extends State<Phase21Form> {
  final _formKey = GlobalKey<FormState>();
  final _marcherController = TextEditingController();
  final _partenairesController = TextEditingController();
  final _institutionnelsController = TextEditingController();
  final _financesController = TextEditingController();

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
            "marcher": "",
            "partenaires": "",
            "institutionnels": "",
            "finances": "",
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
      _data["data"][0]["marcher"] = _marcherController.text.trim();
      _data["data"][0]["partenaires"] = _partenairesController.text.trim();
      _data["data"][0]["institutionnels"] = _institutionnelsController.text.trim();
      _data["data"][0]["finances"] = _financesController.text.trim();

      final resp = await Provider.of<PhaseProvider>(
        context,
        listen: false,
      ).postPhaseData(_data);
      PhaseRefresherScreen.refreshScreen(
        context,
        resp['message'] ??
            "Bravo ! Vous avez complété l'étape 'parties prenantes'. Rendez-vous à l'étape suivante !",
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
            'Qui a intérêt à votre succès et peut vous aider dans votre entreprise ?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText:
                "Qui achète, distribue, influence ou concurrence vos produits et services ?",
            controller: _marcherController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText:
                "Qui est votre partenaire, votre sous-traitant, qui sont les acteurs clés qui vous fournissent ?",
            controller: _partenairesController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText:
                "Qui représente votre entreprise politiquement ou professionnellement ?",
            controller: _institutionnelsController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText: "Qui finance, assure ou investit dans votre projet ?",
            controller: _financesController,
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
