import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController? controller;
  final Function searchAction;
  final Function resetSearch;
  const SearchBar(
      {Key? key,
      this.controller,
      required this.searchAction,
      required this.resetSearch})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: const BorderSide(
          color: Colors.black26,
          width: 1.0,
        ),
      ),
      child: ListTile(
        leading: const Icon(Icons.search),
        title: TextField(
          controller: widget.controller,
          decoration: const InputDecoration(
            hintText: 'Rechercher',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            widget.searchAction(value);
          },
        ),
        trailing: IconButton(
          padding: EdgeInsets.zero,
          hoverColor: Colors.transparent,
          icon: const Icon(Icons.cancel),
          onPressed: () {
            widget.controller!.text = "";
            widget.resetSearch();
          },
        ),
      ),
    );
  }
}
