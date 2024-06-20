import 'package:flutter/material.dart';
import 'package:noviindus_test/core/color_pallette/color_pallete.dart';
import 'package:noviindus_test/core/utils/app_text.dart';
import 'package:noviindus_test/features/home/model/patient_model.dart';
import 'package:noviindus_test/features/home/view/widgets/icon_text.dart';

class PatientCard extends StatefulWidget {
  final Patient patient;
  final int index;
  const PatientCard({super.key, required this.patient, required this.index});

  @override
  State<PatientCard> createState() => _PatientCardState();
}

class _PatientCardState extends State<PatientCard> {
  List<String> treatments = [];
  @override
  void initState() {
    widget.patient.patientDetailsSet?.map((e) => treatments.add(e.treatment.toString()));
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorPallete.lightGrey,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                  child: AppText(
                      text: '${widget.index + 1}',
                      textStyle: Theme.of(context).textTheme.titleMedium),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                          text: widget.patient.name ?? '',
                          textStyle: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(
                        height: 5,
                      ),
                      AppText(
                        text: treatments.join(','),
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        textColor: ColorPallete.themeColor,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconText(
                              text: widget.patient.dateNdTime.toString().split(' ').first,
                              icon: Icons.calendar_month_outlined),
                          const SizedBox(
                            width: 40,
                          ),
                          IconText(text: widget.patient.user?? '', icon: Icons.group_outlined)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(
            height: 3,
            color: ColorPallete.borderColor,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 45, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                    text: 'View Booking Details',
                    textStyle: Theme.of(context).textTheme.bodyMedium),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ColorPallete.themeColor,
                  size: 18,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
