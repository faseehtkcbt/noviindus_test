import 'package:flutter/material.dart';
import 'package:noviindus_test/features/patient/model/treatment_data.dart';
import 'package:noviindus_test/features/patient/view/widget/patients_counter.dart';
import 'package:noviindus_test/features/patient/view_model/register_patient_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../core/color_pallette/color_pallete.dart';
import '../../../../core/counter_provider/counter_provider.dart';
import '../../../../core/utils/app_drop_text_form.dart';
import '../../../../core/utils/app_text.dart';
import '../../model/treatment_model.dart';

class TreatmentSelect extends StatefulWidget {
  final List<Treatment>? treatments;
  const TreatmentSelect({super.key, required this.treatments});

  @override
  State<TreatmentSelect> createState() => _TreatmentSelectState();
}

class _TreatmentSelectState extends State<TreatmentSelect> {
  final formKey = GlobalKey<FormState>();
  int maleCount = 0;
  int femaleCount = 0;
  String? selected;

  Treatment getTreatment(String value) {
    var data;
    for (var i in widget.treatments!) {
      if (i.name.contains(value)) {
        data = i;
      }
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
                text: 'Choose Treatments',
                textStyle: Theme.of(context).textTheme.titleSmall),
            AppDropTextForm(
                hintText: 'Treatments',
                dropDownList: widget.treatments!
                    .map((e) =>
                        e.name.length > 40 ? e.name.substring(0, 40) : e.name)
                    .toList(),
                onChanged: (value) {
                  selected = value;
                }),
            const SizedBox(
              height: 20,
            ),
            AppText(
                text: 'Add Patients',
                textStyle: Theme.of(context).textTheme.titleSmall),
            const SizedBox(
              height: 5,
            ),
            ChangeNotifierProvider<CounterProvider>(
              create: (context) => CounterProvider(),
              child: Consumer<CounterProvider>(
                  builder: (context, maleCounter, child) {
                maleCount = maleCounter.count;
                return PatientsCounter(title: 'Male', count: maleCounter.count);
              }),
            ),
            const SizedBox(
              height: 10,
            ),
            ChangeNotifierProvider<CounterProvider>(
              create: (context) => CounterProvider(),
              child: Consumer<CounterProvider>(
                  builder: (context, femaleCounter, child) {
                femaleCount = femaleCounter.count;
                return PatientsCounter(
                    title: 'Female', count: femaleCounter.count);
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (femaleCount == 0 || maleCount == 0) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Center(
                                child: AppText(
                                    text: 'Check it Out',
                                    textColor: ColorPallete.themeColor,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                              ),
                              content: AppText(
                                  text:
                                      'Please change Male count and Female count',
                                  maxLines: 2,
                                  textStyle:
                                      Theme.of(context).textTheme.bodySmall),
                              actions: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: AppText(
                                    text: 'Cancel',
                                    textStyle:
                                        Theme.of(context).textTheme.bodySmall,
                                    textColor: ColorPallete.errorColor,
                                  ),
                                )
                              ],
                            ));
                  } else if (formKey.currentState!.validate()) {
                    context
                        .read<RegisterPatientViewModel>()
                        .addSelectedTreatment(TreatmentData(
                            getTreatment(selected ?? ''),
                            maleCount,
                            femaleCount));
                    Navigator.pop(context);
                  }
                },
                child: AppText(
                    text: 'Save',
                    textColor: ColorPallete.whiteColor,
                    textStyle: Theme.of(context).textTheme.titleMedium))
          ],
        ),
      ),
    );
  }
}
