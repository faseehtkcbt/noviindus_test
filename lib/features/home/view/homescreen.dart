import 'package:flutter/material.dart';
import 'package:noviindus_test/config/routers/routers.dart';
import 'package:noviindus_test/core/color_pallette/color_pallete.dart';
import 'package:noviindus_test/core/utils/app_text.dart';
import 'package:noviindus_test/core/utils/app_text_form.dart';
import 'package:noviindus_test/features/home/view/widgets/patient_card.dart';
import 'package:noviindus_test/features/home/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final searchController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().getPatients();
    });
    // TODO: implement initState
    super.initState();
  }

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
          child: RefreshIndicator(
        onRefresh: () async {
          return await context.read<HomeViewModel>().getPatients();
        },
        child: Container(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 5, left: 20, right: 20, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                      width: size.width * 0.6,
                      child: AppTextFormField(
                        controller: searchController,
                        hintText: 'Search by name',
                        suffixIcon: const Icon(
                          Icons.search,
                          size: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: size.width * 0.25,
                      child: ElevatedButton(
                          onPressed: () {},
                          child: AppText(
                              text: 'Search',
                              textColor: ColorPallete.whiteColor,
                              textStyle:
                                  Theme.of(context).textTheme.bodySmall)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 5, left: 20, right: 20, bottom: 5),
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
                  child:
                      Consumer<HomeViewModel>(builder: (context, home, child) {
                    if (home.isLoaded == true) {
                      return ListView.separated(
                        itemCount: 10,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return PatientCard(
                            patient: home.patients![index],
                            index: index,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                      );
                    } else if (home.isError == true) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                              content: AppText(
                            text: home.error ?? "",
                            textStyle: Theme.of(context).textTheme.bodySmall,
                            textColor: ColorPallete.whiteColor,
                          )));
                      });
                      return AppText(
                          text: 'Something Went Wrong',
                          textStyle: Theme.of(context).textTheme.bodyMedium);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: ColorPallete.themeColor,
                        ),
                      );
                    }
                  }),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
