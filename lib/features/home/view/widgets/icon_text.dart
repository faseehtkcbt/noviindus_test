import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noviindus_test/core/color_pallette/color_pallete.dart';
import 'package:noviindus_test/core/utils/app_text.dart';

class IconText extends StatefulWidget {
  final String text;
  final IconData icon;
  const IconText({super.key, required this.text, required this.icon});

  @override
  State<IconText> createState() => _IconTextState();
}

class _IconTextState extends State<IconText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          widget.icon,
          color: ColorPallete.errorColor,
          size: 20,
        ),
        SizedBox(
          width: 5,
        ),
        AppText(
            text: widget.text,
            textStyle: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
