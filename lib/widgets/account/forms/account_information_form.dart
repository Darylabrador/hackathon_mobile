import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/account_provider.dart';
import '../../../models/user.dart';
import '../../../models/gender.dart';

import '../../components/gender_select_input.dart';
import '../../components/custom_text_form_field.dart';
import '../../components/double_button_form.dart';

import '../../../utils/snackbar.dart';
import '../../../services/validator_service.dart';

class AccountInformationForm extends StatefulWidget {
  final User accountData;
  const AccountInformationForm({
    Key? key,
    required this.accountData,
  }) : super(key: key);

  @override
  _AccountInformationFormState createState() => _AccountInformationFormState();
}

class _AccountInformationFormState extends State<AccountInformationForm> {
  final _formKey = GlobalKey<FormState>();
  final _surnameController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _yearOldController = TextEditingController();

  late Gender _selectedGender;
  late User _savedData;

  var _isValid = true;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _savedData = widget.accountData;
      _setDataField(widget.accountData);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _setDataField(User data) {
    _surnameController.text = data.surname!;
    _firstnameController.text = data.firstname!;
    _emailController.text = data.email!;
    _yearOldController.text = data.yearOld!.toString();
    _setGender(data.gender!);
  }

  void _setGender(String? gender) {
    switch (gender) {
      case "femme":
        _selectedGender = const Gender(id: 0, name: "femme");
        break;
      case "homme":
        _selectedGender = const Gender(id: 1, name: "homme");
        break;
      default:
        _selectedGender = const Gender(id: 2, name: "non spécifié");
    }
  }

  void _handleSelect(Gender selectedValued) {
    setState(() {
      _selectedGender = selectedValued;
    });
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _setDataField(_savedData);
    setState(() {});
  }

  Future<void> _submitHandler(BuildContext context) async {
    if (_selectedGender is Gender) {
      setState(() {
        _isValid = true;
      });
    } else {
      setState(() {
        _isValid = false;
      });
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    try {
      Map<String, dynamic> repData = await Provider.of<AccountProvider>(
        context,
        listen: false,
      ).updateAccount(
        email: _emailController.text.trim(),
        surname: _surnameController.text.trim(),
        firstname: _firstnameController.text.trim(),
        gender: _selectedGender.id,
        age: int.parse(_yearOldController.text),
      );
      Snackbar.showScaffold(repData['message'], repData["success"], context);
    } catch (e) {
      Snackbar.showScaffold(e.toString(), false, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Form(
      key: _formKey,
      child: SizedBox(
        width: mediaQuery.size.width * 0.9,
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomTextFormField(
              labelText: "Votre nom de famille",
              controller: _surnameController,
              validator: (value) => ValidatorService.validateField(value),
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              labelText: "Votre prénom",
              controller: _firstnameController,
              validator: (value) => ValidatorService.validateField(value),
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              labelText: "Votre adresse e-mail",
              controller: _emailController,
              validator: (value) => ValidatorService.validateEmail(value),
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              labelText: "Votre age",
              controller: _yearOldController,
              validator: (value) => ValidatorService.validateAge(value),
            ),
            const SizedBox(height: 10),
            GenderSelectInput(
              isValid: _isValid,
              handleSelect: _handleSelect,
              selectedGender: _selectedGender,
            ),
            const SizedBox(height: 20),
            DoubleButtonForm(
              cancelHanlder: _resetForm,
              cancelText: "Annuler",
              validHandler: () => _submitHandler(context),
              validText: "Valider",
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
