import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../../components/custom_button_next_phase.dart';
import '../../../providers/phase_provider.dart';

import '../../components/custom_text_form_field.dart';
import '../../../utils/snackbar.dart';
import '../../../models/phase.dart';
import '../forms/phase_refresher_screen.dart';

class Phase13Form extends StatefulWidget {
  final Phase showingPhase;
  final List<dynamic>? projectData;

  const Phase13Form({
    Key? key,
    this.projectData,
    required this.showingPhase,
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

  var _displayHowLabel = false;
  var _displayForWhoLabel = false;
  var _displayWhyNowLabel = false;
  var _displayWhoAreYouLabel = false;
  var _displayWhyLabel = false;

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
            "comment": saved == null ? "" : saved["comment"],
            "pour_qui": saved == null ? "" : saved["pour_qui"],
            "pourquoi_maintenant":
                saved == null ? "" : saved["pourquoi_maintenant"],
            "qui_etes_vous": saved == null ? "" : saved["qui_etes_vous"],
            "pourquoi": saved == null ? "" : saved["pourquoi"],
          }
        ]
      };

      _commentController.text = saved == null ? "" : saved["comment"];
      _pourQuiController.text = saved == null ? "" : saved["pour_qui"];
      _pourquoiMaintenantController.text = saved == null ? "" : saved["pourquoi_maintenant"];
      _quiEtesVousController.text = saved == null ? "" : saved["qui_etes_vous"];
      _pourquoiController.text = saved == null ? "" : saved["pourquoi"];

      onChangeHowValue(saved == null ? null : saved["comment"]);
      onChangeForWhoValue(saved == null ? null : saved["pour_qui"]);
      onChangeWhyNowValue(saved == null ? null : saved["pourquoi_maintenant"]);
      onChangeWhoAreYouValue(saved == null ? null : saved["qui_etes_vous"]);
      onChangeWhyValue(saved == null ? null : saved["pourquoi"]);
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
      _data["data"][0]["pourquoi_maintenant"] =
          _pourquoiMaintenantController.text.trim();
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

  void onChangeHowValue(String? value) {
    if (value == null || value == "") {
      setState(() {
        _displayHowLabel = false;
      });
    } else {
      setState(() {
        _displayHowLabel = true;
      });
    }
  }

  void onChangeForWhoValue(String? value) {
    if (value == null || value == "") {
      setState(() {
        _displayForWhoLabel = false;
      });
    } else {
      setState(() {
        _displayForWhoLabel = true;
      });
    }
  }

  void onChangeWhyNowValue(String? value) {
    if (value == null || value == "") {
      setState(() {
        _displayWhyNowLabel = false;
      });
    } else {
      setState(() {
        _displayWhyNowLabel = true;
      });
    }
  }

  void onChangeWhoAreYouValue(String? value) {
    if (value == null || value == "") {
      setState(() {
        _displayWhoAreYouLabel = false;
      });
    } else {
      setState(() {
        _displayWhoAreYouLabel = true;
      });
    }
  }

  void onChangeWhyValue(String? value) {
    if (value == null || value == "") {
      setState(() {
        _displayWhyLabel = false;
      });
    } else {
      setState(() {
        _displayWhyLabel = true;
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
            labelText: _displayHowLabel
                ? "Vos compétences, moyens, partenaires"
                : null,
            minLines: 5,
            maxLines: 10,
            hintText:
                "Quelles compétences, moyens ou partenaires entrent dans la création et le développement de votre projet ?",
            controller: _commentController,
            onChanged: (value) => onChangeHowValue(value),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            labelText: _displayForWhoLabel ? "Qui est votre client ?" : null,
            minLines: 5,
            maxLines: 10,
            hintText: "Qui est votre client, où est il ?",
            controller: _pourQuiController,
            onChanged: (value) => onChangeForWhoValue(value),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            labelText: _displayWhyNowLabel
                ? "Pourquoi il faut le faire maintenant ?"
                : null,
            minLines: 5,
            maxLines: 10,
            hintText:
                "Et rajoutez également pourquoi il faut le faire maintenant, quelle urgence, quel impératif ou opportunité",
            controller: _pourquoiMaintenantController,
            onChanged: (value) => onChangeWhyNowValue(value),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            labelText: _displayWhoAreYouLabel
                ? "Votre parcours, vos compétences, ce que vous aimez faire"
                : null,
            minLines: 5,
            maxLines: 10,
            hintText:
                "Quel est votre parcours, vos compétences, ce que vous aimez faire et ce en quoi vous êtes reconnu(e)",
            controller: _quiEtesVousController,
            onChanged: (value) => onChangeWhoAreYouValue(value),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            labelText:
                _displayWhyLabel ? "Quelles sont vos motivations ?" : null,
            minLines: 5,
            maxLines: 10,
            hintText:
                "Entreprendre est une aventure risquée, dites nous quelles sont vos motivations, cette envie, cette passion, ce besoin ou cette rage qui vous font avancer.",
            controller: _pourquoiController,
            onChanged: (value) => onChangeWhyValue(value),
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
