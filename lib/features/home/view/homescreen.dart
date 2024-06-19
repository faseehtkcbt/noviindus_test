import 'package:flutter/material.dart';
import 'package:noviindus_test/config/routers/routers.dart';
import 'package:noviindus_test/core/color_pallette/color_pallete.dart';
import 'package:noviindus_test/core/utils/app_text.dart';
import 'package:noviindus_test/features/home/view/widgets/patient_card.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.notifications_none,
              size: 25,
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, Routers.addPatientScreen);
            },
            child: AppText(
              text: 'Register Now',
              textStyle: Theme.of(context).textTheme.titleMedium,
              textColor: ColorPallete.whiteColor,
            )),
      ),
      body: Center(
          child: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  AppText(
                      text: 'Sort By:',
                      textStyle: Theme.of(context).textTheme.titleSmall),
                ],
              ),
            ),
            const Divider(
              height: 3,
              color: ColorPallete.borderColor,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.separated(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return PatientCard();
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
