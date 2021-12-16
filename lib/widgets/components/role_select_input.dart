import 'package:flutter/material.dart';
import '../../models/role.dart';
import '../../utils/palette.dart';

class RoleSelectInput extends StatefulWidget {
  final bool isValid;
  final Function handleSelect;
  final Role selectedRole;

  const RoleSelectInput({
    required this.isValid,
    required this.handleSelect,
    required this.selectedRole,
    Key? key,
  }) : super(key: key);

  @override
  _GenderSelectInputState createState() => _GenderSelectInputState();
}

class _GenderSelectInputState extends State<RoleSelectInput> {
  var _isInit = true;

  final List<Role> roleList = [
    const Role(name: '0 - choisir un role'),
    const Role(name: 'chef de projet'),
    const Role(name: "gestion de projet"),
    const Role(name: 'porteur de projet'),
    const Role(name: "marketing"),
    const Role(name: "commercial"),
    const Role(name: "finance"),
    const Role(name: "developpement"),
    const Role(name: "communication"),
    const Role(name: 'invite'),
  ];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      roleList.sort((a, b) => a.name.toString().compareTo(b.name.toString()));
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Role>(
      decoration: InputDecoration(
        labelText: "Sélectionner un rôle",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isValid ? Palette.bluePostale : Colors.red,
            width: 1.0,
          ),
        ),
      ),
      isExpanded: true,
      value: widget.selectedRole,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      onSaved: (value) => widget.handleSelect(value),
      onChanged: (Role? newValue) {
        widget.handleSelect(newValue);
        setState(() {});
      },
      items: roleList.map<DropdownMenuItem<Role>>((value) {
        return DropdownMenuItem<Role>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }
}
