import 'package:flutter/material.dart';
import 'package:noviindus_test/core/color_pallette/color_pallete.dart';
import 'package:noviindus_test/features/patient/model/treatment_data.dart';
import 'package:noviindus_test/features/patient/view_model/register_patient_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/app_text.dart';

class Treatmentcard extends StatefulWidget {
  final int index;
  final TreatmentData data;
  const Treatmentcard({super.key, required this.index, required this.data});

  @override
  State<Treatmentcard> createState() => _TreatmentcardState();
}

class _TreatmentcardState extends State<Treatmentcard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorPallete.lightGrey,
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 30,
            child: AppText(
                text: '${widget.index + 1}.',
                textStyle: Theme.of(context).textTheme.bodyMedium),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                    text: widget.data.treatment.name,
                    textStyle: Theme.of(context).textTheme.titleSmall),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppText(
                        text: 'Male',
                        textColor: ColorPallete.themeColor,
                        textStyle: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 25,
                      width: 40,
                      decoration: BoxDecoration(
                          color: ColorPallete.lightGrey,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: ColorPallete.borderColor, width: 2)),
                      child: Center(
                        child: AppText(
                            text: widget.data.maleCount.toString(),
                            textStyle: Theme.of(context).textTheme.bodySmall),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    AppText(
                        text: 'Female',
                        textColor: ColorPallete.themeColor,
                        textStyle: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 25,
                      width: 40,
                      decoration: BoxDecoration(
                          color: ColorPallete.lightGrey,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: ColorPallete.borderColor, width: 2)),
                      child: Center(
                        child: AppText(
                            text: widget.data.femaleCount.toString(),
                            textStyle: Theme.of(context).textTheme.bodySmall),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          GestureDetector(
              onTap: () {
                context
                    .read<RegisterPatientViewModel>()
                    .removeSelectedTreatment(widget.data);
              },
              child: const Icon(
                Icons.dangerous,
                color: ColorPallete.errorColor,
                size: 23,
              ))
        ],
      ),
    );
  }
}
