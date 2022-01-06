import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

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
    this.projectData,
    required this.showingPhase,
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

  var _displayMarcherLabel = false;
  var _displayPartenairesLabel = false;
  var _displayInstitutionnelsLabel = false;
  var _displayFinancesLabel = false;

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
            "marcher": saved == null ? "" : saved["marcher"],
            "partenaires": saved == null ? "" : saved["partenaires"],
            "institutionnels": saved == null ? "" : saved["institutionnels"],
            "finances": saved == null ? "" : saved["finances"],
          }
        ]
      };

      _marcherController.text = saved == null ? "" : saved["marcher"];
      _partenairesController.text = saved == null ? "" : saved["partenaires"];
      _institutionnelsController.text =
          saved == null ? "" : saved["institutionnels"];
      _financesController.text = saved == null ? "" : saved["finances"];

      onChangeMarcherValue(saved == null ? null : saved["marcher"]);
      onChangePartenairesValue(saved == null ? null : saved["partenaires"]);
      onChangeInstitutionnelsValue(
          saved == null ? null : saved["institutionnels"]);
      onChangeFinancesValue(saved == null ? null : saved["finances"]);
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
      _data["data"][0]["institutionnels"] =
          _institutionnelsController.text.trim();
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

  void onChangeMarcherValue(String? value) {
    if (value == null || value == "") {
      setState(() {
        _displayMarcherLabel = false;
      });
    } else {
      setState(() {
        _displayMarcherLabel = true;
      });
    }
  }

  void onChangePartenairesValue(String? value) {
    if (value == null || value == "") {
      setState(() {
        _displayPartenairesLabel = false;
      });
    } else {
      setState(() {
        _displayPartenairesLabel = true;
      });
    }
  }

  void onChangeInstitutionnelsValue(String? value) {
    if (value == null || value == "") {
      setState(() {
        _displayInstitutionnelsLabel = false;
      });
    } else {
      setState(() {
        _displayInstitutionnelsLabel = true;
      });
    }
  }

  void onChangeFinancesValue(String? value) {
    if (value == null || value == "") {
      setState(() {
        _displayFinancesLabel = false;
      });
    } else {
      setState(() {
        _displayFinancesLabel = true;
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
            'Qui a intérêt à votre succès et peut vous aider dans votre entreprise ?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            labelText: _displayMarcherLabel
                ? "Qui achète, distribue, influence ou concurrence vos produits et services ?"
                : null,
            minLines: 5,
            maxLines: 15,
            hintText:
                "Qui achète, distribue, influence ou concurrence vos produits et services ?",
            controller: _marcherController,
            onChanged: (value) => onChangeMarcherValue(value),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            labelText: _displayPartenairesLabel
                ? "Qui sont les acteurs clés (partenaire, sous-traitant..)"
                : null,
            minLines: 5,
            maxLines: 15,
            hintText:
                "Qui est votre partenaire, votre sous-traitant, qui sont les acteurs clés qui vous fournissent ?",
            controller: _partenairesController,
            onChanged: (value) => onChangePartenairesValue(value),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            labelText: _displayInstitutionnelsLabel
                ? "Qui représente votre entreprise politiquement ou professionnellement ?"
                : null,
            minLines: 5,
            maxLines: 15,
            hintText:
                "Qui représente votre entreprise politiquement ou professionnellement ?",
            controller: _institutionnelsController,
            onChanged: (value) => onChangeInstitutionnelsValue(value),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            labelText: _displayFinancesLabel
                ? "Qui finance, assure ou investit dans votre projet ?"
                : null,
            minLines: 5,
            maxLines: 15,
            hintText: "Qui finance, assure ou investit dans votre projet ?",
            controller: _financesController,
            onChanged: (value) => onChangeFinancesValue(value),
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
