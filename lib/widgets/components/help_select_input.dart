import 'package:flutter/material.dart';
import '../../models/help.dart';
import '../../utils/palette.dart';

class HelpSelectInput extends StatefulWidget {
  final bool isValid;
  final Function handleSelect;
  final Help selectedSubject;

  const HelpSelectInput({
    required this.isValid,
    required this.handleSelect,
    required this.selectedSubject,
    Key? key,
  }) : super(key: key);

  @override
  _HelpSelectInputState createState() => _HelpSelectInputState();
}

class _HelpSelectInputState extends State<HelpSelectInput> {
  final subjectList = [
    const Help(name:"Sujet de la demande d'aide"),
    const Help(name:"Je suis bloque"),
    const Help(name:"Je ne vois pas le dashboard"),
    const Help(name:"Probleme pour acceder a un element du menu"),
    const Help(name:"Il y a un bug"),
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Help>(
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
      value: widget.selectedSubject,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      onSaved: (value) => widget.handleSelect(value),
      onChanged: (Help? newValue) {
        widget.handleSelect(newValue);
      },
      items: subjectList.map<DropdownMenuItem<Help>>((value) {
        return DropdownMenuItem<Help>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }
}
