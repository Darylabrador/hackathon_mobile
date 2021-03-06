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
  ValidatorService validator = ValidatorService.getInstance();

  var _isInit = true;
  var _data = {};
  var _displayedlabel = false;

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

      var dataText = saved == null ? "" : saved["quoi"];
      _quoiController.text = dataText;
      onChangeValue(dataText == "" ? null : dataText);
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
            "Bravo ! Vous avez finalis?? la pr??sentation de votre id??e pour l'Id??athon Alternatives au cash.",
        resp['success'],
      );
    } catch (e) {
      Snackbar.showScaffold(e.toString(), false, context);
    }
  }

  void onChangeValue(String? value) {
    if (value == null || value == "") {
      setState(() {
        _displayedlabel = false;
      });
    } else {
      setState(() {
        _displayedlabel = true;
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
            labelText: _displayedlabel ? 'D??taillez votre offre' : null,
            minLines: 5,
            maxLines: 50,
            hintText:
                "D??taillez votre offre avec des mots simples et clairs, comme par exemple : ?? Ce mini-guide de questions vous permet de construire une pr??sentation d??taill??e de votre projet. il est compos?? de 3 phases cl??s amenant ?? une pr??sentation finale id??ale pour convaincre.",
            controller: _quoiController,
            validator: (value) => validator.validateField(value),
            onChanged: (value) => onChangeValue(value),
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
