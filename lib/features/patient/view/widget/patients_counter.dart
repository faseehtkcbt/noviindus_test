import 'package:flutter/material.dart';
import 'package:noviindus_test/core/counter_provider/counter_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/color_pallette/color_pallete.dart';
import '../../../../core/utils/app_text.dart';

class PatientsCounter extends StatefulWidget {
  final String title;
  final int count;
  const PatientsCounter({super.key, required this.title, required this.count});

  @override
  State<PatientsCounter> createState() => _PatientsCounterState();
}

class _PatientsCounterState extends State<PatientsCounter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 45,
          width: 140,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: ColorPallete.lightGrey,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorPallete.borderColor, width: 2)),
          child: Center(
            child: AppText(
                text: widget.title,
                textStyle: Theme.of(context).textTheme.bodyMedium),
          ),
        ),
        Container(
          height: 45,
          width: 190,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  context.read<CounterProvider>().decrease(widget.count);
                },
                child: const CircleAvatar(
                  radius: 30,
                  backgroundColor: ColorPallete.themeColor,
                  child: Icon(
                    Icons.remove,
                    color: ColorPallete.whiteColor,
                  ),
                ),
              ),
              Container(
                height: 45,
                width: 70,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: ColorPallete.lightGrey,
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: ColorPallete.borderColor, width: 2)),
                child: Center(
                  child: AppText(
                      text: widget.count.toString(),
                      textStyle: Theme.of(context).textTheme.bodySmall),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<CounterProvider>().increase(widget.count);
                },
                child: const CircleAvatar(
                  radius: 30,
                  backgroundColor: ColorPallete.themeColor,
                  child: Icon(
                    Icons.add,
                    color: ColorPallete.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
