import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button_next_phase.dart';
import '../../../providers/phase_provider.dart';

import '../../components/custom_text_form_field.dart';
import '../../../utils/snackbar.dart';
import '../../../models/phase.dart';
import '../forms/phase_refresher_screen.dart';

class Phase24Form extends StatefulWidget {
  final Phase showingPhase;
  final List<dynamic>? projectData;
  const Phase24Form({
    Key? key,
    required this.showingPhase,
    this.projectData,
  }) : super(key: key);

  @override
  _Phase24FormState createState() => _Phase24FormState();
}

class _Phase24FormState extends State<Phase24Form> {
  final _formKey = GlobalKey<FormState>();
  final _matieresController = TextEditingController();
  final _investissementsController = TextEditingController();
  final _fournisseursController = TextEditingController();
  final _salairesController = TextEditingController();
  final _coutMatieresController = TextEditingController();
  final _coutInvestissementsController = TextEditingController();
  final _coutFournisseursController = TextEditingController();
  final _coutSalairesController = TextEditingController();
  final _totalCoutsController = TextEditingController();
  final _totalVentesController = TextEditingController();
  final _margeController = TextEditingController();

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
            "matieres": "",
            "investissements": "",
            "fournisseurs": "",
            "salaires": "",
            "cout_matieres": "",
            "cout_investissements": "",
            "cout_fournisseurs": "",
            "cout_salaires": "",
            "totalCouts": "",
            "totalVentes": "",
            "marge": "",
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
      _data["data"][0]["matieres"] = _matieresController.text.trim();
      _data["data"][0]["investissements"] = _investissementsController.text.trim();
      _data["data"][0]["fournisseurs"] = _fournisseursController.text.trim();
      _data["data"][0]["salaires"] = _salairesController.text.trim();
      _data["data"][0]["cout_matieres"] = _coutMatieresController.text.trim();
      _data["data"][0]["cout_investissements"] = _coutInvestissementsController.text.trim();
      _data["data"][0]["cout_fournisseurs"] = _coutFournisseursController.text.trim();
      _data["data"][0]["cout_salaires"] = _coutSalairesController.text.trim();
      _data["data"][0]["totalCouts"] = _totalCoutsController.text.trim();
      _data["data"][0]["totalVentes"] = _totalVentesController.text.trim();
      _data["data"][0]["marge"] = _margeController.text.trim();

      final resp = await Provider.of<PhaseProvider>(
        context,
        listen: false,
      ).postPhaseData(_data);
      PhaseRefresherScreen.refreshScreen(
        context,
        resp['message'] ??
            "Bravo ! Vous avez défini votre Business Model. Rendez-vous à l'étape suivante !",
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
            'CALCUL DU PRIX DE REVIENT ET DU PRIX DE VENTE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText: "Total des coûts",
            controller: _totalCoutsController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText: "Total des ventes",
            controller: _totalVentesController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText: "Marge",
            controller: _margeController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText: "Matières première",
            controller: _matieresController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText: "Matières première (coût)",
            controller: _coutMatieresController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText: "Investissements",
            controller: _investissementsController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText: "Investissements (coût)",
            controller: _coutInvestissementsController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText: "Fournisseurs",
            controller: _fournisseursController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText: "Fournisseurs (coût)",
            controller: _coutFournisseursController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText: "Salaires",
            controller: _salairesController,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            minLines: 5,
            maxLines: 15,
            hintText: "Salaires (coût)",
            controller: _coutSalairesController,
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
