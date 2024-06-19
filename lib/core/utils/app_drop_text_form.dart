import 'package:flutter/material.dart';
import 'package:noviindus_test/core/utils/app_text.dart';

class AppDropTextForm extends StatefulWidget {
  String hintText;
  List<String> dropDownList;
  void Function(String?) onChanged;
  AppDropTextForm(
      {super.key,
      required this.hintText,
      required this.dropDownList,
      required this.onChanged});

  @override
  State<AppDropTextForm> createState() => _AppDropTextFormState();
}

class _AppDropTextFormState extends State<AppDropTextForm> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: (value) {
        if (value == null) {
          return "Please select one from the suggestions";
        }
        return null;
      },
      decoration: InputDecoration(hintText: widget.hintText),
      items: widget.dropDownList.map((String data) {
        return DropdownMenuItem<String>(
          value: data,
          child: AppText(
            text: data,
            textStyle: Theme.of(context).textTheme.bodySmall,
          ),
        );
      }).toList(),
      onChanged: widget.onChanged,
    );
  }
}
