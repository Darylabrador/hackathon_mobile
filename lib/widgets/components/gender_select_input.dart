import 'package:flutter/material.dart';
import '../../models/gender.dart';
import '../../utils/palette.dart';

class GenderSelectInput extends StatefulWidget {
  final bool isValid;
  final Function handleSelect;
  final Gender selectedGender;
  
  const GenderSelectInput({
    required this.isValid,
    required this.handleSelect,
    required this.selectedGender,
    Key? key,
  }) : super(key: key);

  @override
  _GenderSelectInputState createState() => _GenderSelectInputState();
}

class _GenderSelectInputState extends State<GenderSelectInput> {
  final genderList = [
    const Gender(id: 0, name: "femme"),
    const Gender(id: 1, name: "homme"),
    const Gender(id: 2, name: "non spécifié"),
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Gender>(
      decoration: InputDecoration(
        labelText: "Votre sexe",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isValid ? Palette.bluePostale : Colors.red,
            width: 1.0,
          ),
        ),
      ),
      isExpanded: true,
      value: widget.selectedGender,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      onSaved: (value) =>  widget.handleSelect(value),
      onChanged: (Gender? newValue) {
        widget.handleSelect(newValue);
      },
      items: genderList.map<DropdownMenuItem<Gender>>((value) {
        return DropdownMenuItem<Gender>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }
}
