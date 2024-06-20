import 'package:flutter/material.dart';
import 'package:noviindus_test/core/color_pallette/color_pallete.dart';
import 'package:noviindus_test/core/utils/app_text.dart';

class AddTreatmentButton extends StatelessWidget {
  final void Function()? addFunction;
  const AddTreatmentButton({super.key, this.addFunction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: addFunction,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorPallete.lightThemeColor
        ),
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add),
            AppText(text: 'Add Treatments', textStyle: Theme.of(context).textTheme.bodyMedium)
          ],
        ),
      ),
    );
  }
}
