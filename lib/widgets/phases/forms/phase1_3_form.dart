import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button_next_phase.dart';
import '../../../providers/phase_provider.dart';

import '../../components/custom_text_form_field.dart';
import '../../../services/validator_service.dart';
import '../../../utils/snackbar.dart';
import '../../../models/phase.dart';
import '../forms/phase_refresher_screen.dart';

class Phase13Form extends StatefulWidget {
  final Phase showingPhase;
  final List<dynamic>? projectData;
  const Phase13Form({
    Key? key,
    required this.showingPhase,
    this.projectData,
  }) : super(key: key);

  @override
  _Phase13FormState createState() => _Phase13FormState();
}

class _Phase13FormState extends State<Phase13Form> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  final _pourQuiController = TextEditingController();
  final _pourquoiMaintenantController = TextEditingController();
  final _quiEtesVousController = TextEditingController();
  final _pourquoiController = TextEditingController();

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
            "comment": "",
            "pour_qui": "",
            "pourquoi_maintenant": "",
            "qui_etes_vous": "",
            "pourquoi": "",
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
      _data["data"][0]["comment"] = _commentController.text.trim();
      _data["data"][0]["pour_qui"] = _pourQuiController.text.trim();
      _data["data"][0]["pourquoi_maintenant"] = _pourquoiMaintenantController.text.trim();
      _data["data"][0]["qui_etes_vous"] = _quiEtesVousController.text.trim();
      _data["data"][0]["pourquoi"] = _pourquoiController.text.trim();

      final resp = await Provider.of<PhaseProvider>(
        context,
        listen: false,
      ).postPhaseData(_data);
      PhaseRefresherScreen.refreshScreen(
        context,
        resp['message'] ?? "Bravo ! Vous avez complété votre idée.",
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
            hintText: "Quelles compétences, moyens ou partenaires entrent dans la création et le développement de votre projet ?",
            controller: _commentController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 10,
            hintText: "Qui est votre client, où est il ?",
            controller: _pourQuiController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 10,
            hintText: "Et rajoutez également pourquoi il faut le faire maintenant, quelle urgence, quel impératif ou opportunité",
            controller: _pourquoiMaintenantController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 10,
            hintText: "Quel est votre parcours, vos compétences, ce que vous aimez faire et ce en quoi vous êtes reconnu(e)",
            controller: _quiEtesVousController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 10,
            hintText: "Entreprendre est une aventure risquée, dites nous quelles sont vos motivations, cette envie, cette passion, ce besoin ou cette rage qui vous font avancer.",
            controller: _pourquoiController,
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
