import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noviindus_test/core/color_pallette/color_pallete.dart';
import 'package:noviindus_test/core/constants/constants.dart';
import 'package:noviindus_test/core/utils/app_drop_text_form.dart';
import 'package:noviindus_test/core/utils/app_text.dart';
import 'package:noviindus_test/core/utils/app_text_form.dart';
import 'package:noviindus_test/features/patient/view/widget/TreatmentCard.dart';
import 'package:noviindus_test/features/patient/view/widget/add_treatment_button.dart';
import 'package:noviindus_test/features/patient/view/widget/treatment_select.dart';
import 'package:noviindus_test/features/patient/view_model/branch_view_model.dart';
import 'package:noviindus_test/features/patient/view_model/register_patient_view_model.dart';
import 'package:noviindus_test/features/patient/view_model/treatment_view_model.dart';
import 'package:provider/provider.dart';

import '../../../config/routers/routers.dart';
import '../../../core/radio_provider/radio_provider.dart';
import '../model/branch_model.dart';
import '../model/treatment_data.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final totalAmountController = TextEditingController();
  final discountAmountController = TextEditingController();
  final advanceAmountController = TextEditingController();
  final balanceAmountController = TextEditingController();
  final treatmentDateController = TextEditingController();
  String? selectedLocation;
  String? selectedBranches;
  String? selectedHour;
  String? selectedMinute;
  DateTime? selectedDate;
  int totalCount = 0;
  String payment = 'Card';

  Branch getBranch(String value) {
    List<Branch>? result = context.read<BranchViewModel>().branches;
    var data;
    for (var i in result!) {
      if (i.name.contains(value)) {
        data = i;
      }
    }
    return data;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BranchViewModel>().getBranches();
      context.read<TreatmentViewModel>().getTreatments();
    });
    // TODO: implement initState
    super.initState();
  }

  Widget buildTreatmentCards(List<TreatmentData> data) {
    List<Widget> treatmentCards = [];
    totalCount = 0;
    for (int i = 0; i < data.length; i++) {
      totalCount = totalCount +
          ((data[i].maleCount + data[i].femaleCount) *
              int.parse(data[i].treatment.price));
      if (totalCount > 0) {
        totalAmountController.text = totalCount.toString();
        discountAmountController.text = (totalCount * 0.1).toString();
        balanceAmountController.text =
            (totalCount - double.parse(discountAmountController.text ?? '0'))
                .toString();
        advanceAmountController.text = "";
      }
      treatmentCards.add(Treatmentcard(index: i, data: data[i]));
    }

    return Column(
      children: treatmentCards,
    );
  }

  String getDateTime(DateTime date, int hour, int min) {
    // Create a new DateTime object with the provided hour and minute
    DateTime newDateTime = DateTime(date.year, date.month, date.day, hour, min);

    // Format the date part as 'MM/dd/yyyy'
    String formattedDate = DateFormat('MM/dd/yyyy').format(newDateTime);

    // Format the time part as 'hh:mm a' (12-hour format with AM/PM)
    String formattedTime = DateFormat('hh:mm a').format(newDateTime);

    // Combine both parts
    return '$formattedDate-$formattedTime';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<RegisterPatientViewModel>(
        builder: (context, patient, child) {
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
          body: SafeArea(
              child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 10.0),
                  child: AppText(
                      text: 'Register',
                      textStyle: Theme.of(context).textTheme.titleLarge),
                ),
                const Divider(
                  color: ColorPallete.borderColor,
                  height: 3,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                                text: 'Name',
                                textStyle:
                                    Theme.of(context).textTheme.titleSmall),
                            AppTextFormField(
                              controller: usernameController,
                              hintText: 'Enter your full name',
                              textInputType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            AppText(
                                text: 'Whatsapp Number',
                                textStyle:
                                    Theme.of(context).textTheme.titleSmall),
                            AppTextFormField(
                              controller: phoneController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              hintText: 'Enter your whatsapp number',
                              textInputType: TextInputType.phone,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter whatsapp number';
                                } else if (value.length != 10) {
                                  return 'Please enter valid mobile number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            AppText(
                                text: 'Address',
                                textStyle:
                                    Theme.of(context).textTheme.titleSmall),
                            AppTextFormField(
                              controller: addressController,
                              hintText: 'Enter your address',
                              maxLines: 3,
                              textInputType: TextInputType.streetAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            AppText(
                                text: 'Locations',
                                textStyle:
                                    Theme.of(context).textTheme.titleSmall),
                            AppDropTextForm(
                              dropDownList: AppConstants.locations,
                              onChanged: (String? newValue) {
                                selectedLocation = newValue!;
                              },
                              hintText: 'Select your location',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Consumer<BranchViewModel>(
                                builder: (context, branch, child) {
                              if (branch.isLoading == false) {
                                if (branch.isLoaded == true) {
                                  List<String> branchList = [];
                                  branch.branches
                                      ?.map((e) => branchList.add(e.name))
                                      .toList();
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                          text: 'Branches',
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .titleSmall),
                                      AppDropTextForm(
                                        dropDownList: branchList,
                                        onChanged: (String? newValue) {
                                          selectedBranches = newValue!;
                                        },
                                        hintText: 'Select your branches',
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: ColorPallete.themeColor,
                                  ),
                                );
                              }
                            }),
                            const SizedBox(
                              height: 5,
                            ),
                            AppText(
                                text: 'Treatments',
                                textStyle:
                                    Theme.of(context).textTheme.titleSmall),
                            buildTreatmentCards(patient.selectedTreatment),
                            Consumer<TreatmentViewModel>(
                                builder: (context, treatments, child) {
                              return AddTreatmentButton(
                                addFunction: () {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    builder: (BuildContext context) {
                                      return TreatmentSelect(
                                          treatments: treatments.treatments);
                                    },
                                  );
                                },
                              );
                            }),
                            const SizedBox(
                              height: 5,
                            ),
                            AppText(
                                text: 'Total Amount',
                                textStyle:
                                    Theme.of(context).textTheme.titleSmall),
                            AppTextFormField(
                              controller: totalAmountController,
                              hintText: 'Total Amount to pay',
                              readOnly: true,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            AppText(
                                text: 'Discount Amount',
                                textStyle:
                                    Theme.of(context).textTheme.titleSmall),
                            AppTextFormField(
                              controller: discountAmountController,
                              hintText: 'Discount Amount',
                              readOnly: true,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            AppText(
                                text: 'Payment',
                                textStyle:
                                    Theme.of(context).textTheme.titleSmall),
                            ChangeNotifierProvider<RadioProvider>(
                              create: (context) => RadioProvider(),
                              child: Consumer<RadioProvider>(
                                  builder: (context, radio, child) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: size.width * 0.5,
                                      child: RadioListTile(
                                          selected: radio.value == 'Cash',
                                          value: 'Cash',
                                          title: AppText(
                                            text: 'Cash',
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          groupValue: payment,
                                          onChanged: (value) {
                                            payment = value!;
                                            context
                                                .read<RadioProvider>()
                                                .changeRadion(value);
                                          }),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: size.width * 0.3,
                                      child: RadioListTile(
                                          selected: radio.value == 'Card',
                                          title: AppText(
                                            text: 'Card',
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          value: 'Card',
                                          groupValue: payment,
                                          onChanged: (value) {
                                            payment = value!;
                                            context
                                                .read<RadioProvider>()
                                                .changeRadion(value);
                                          }),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: size.width * 0.3,
                                      child: RadioListTile(
                                          selected: radio.value == 'UPI',
                                          title: AppText(
                                            text: 'UPI',
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          value: 'UPI',
                                          groupValue: payment,
                                          onChanged: (value) {
                                            payment = value!;
                                            context
                                                .read<RadioProvider>()
                                                .changeRadion(value);
                                          }),
                                    ),
                                  ],
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            AppText(
                                text: 'Advance Amount',
                                textStyle:
                                    Theme.of(context).textTheme.titleSmall),
                            AppTextFormField(
                              controller: advanceAmountController,
                              hintText: 'Enter advance amount wish to pay',
                              textInputType: TextInputType.number,
                              onChanged: (value) {
                                double maximum =
                                    (double.parse(totalAmountController.text) -
                                        double.parse(
                                            discountAmountController.text));
                                if (value.isNotEmpty) {
                                  if (double.parse(value) <= maximum) {
                                    balanceAmountController
                                        .text = (double.parse(
                                                totalAmountController.text) -
                                            double.parse(
                                                discountAmountController.text) -
                                            double.parse(
                                                advanceAmountController.text))
                                        .toString();
                                  } else {
                                    balanceAmountController
                                        .text = (double.parse(
                                                totalAmountController.text) -
                                            double.parse(
                                                discountAmountController.text))
                                        .toString();
                                  }
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please specify a advance amount';
                                }
                                double maximum =
                                    (double.parse(totalAmountController.text) -
                                        double.parse(
                                            discountAmountController.text));
                                if (double.parse(value) > maximum) {
                                  return 'Please check the entered amount';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            AppText(
                                text: 'Balance Amount',
                                textStyle:
                                    Theme.of(context).textTheme.titleSmall),
                            AppTextFormField(
                              controller: balanceAmountController,
                              hintText: 'Balance Amount to pay',
                              readOnly: true,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            AppText(
                                text: 'Treatment Date',
                                textStyle:
                                    Theme.of(context).textTheme.titleSmall),
                            AppTextFormField(
                              controller: treatmentDateController,
                              hintText: 'Choose a date',
                              readOnly: true,
                              suffixIcon: const Icon(Icons.calendar_month),
                              onPressed: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2055),
                                );
                                if (picked != selectedDate) {
                                  selectedDate = picked;
                                  treatmentDateController.text =
                                      selectedDate.toString().split(' ').first;
                                }
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please choose a date';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            AppText(
                                text: 'Treatment Time (24 hrs)',
                                textStyle:
                                    Theme.of(context).textTheme.titleSmall),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: size.width * .45,
                                  child: AppDropTextForm(
                                      hintText: 'Hour',
                                      dropDownList: List.generate(
                                          24,
                                          (index) =>
                                              index.toString().padLeft(2, '0')),
                                      onChanged: (value) {
                                        selectedHour = value;
                                      }),
                                ),
                                SizedBox(
                                  width: size.width * .45,
                                  child: AppDropTextForm(
                                      hintText: 'Minute',
                                      dropDownList: List.generate(
                                          60,
                                          (index) =>
                                              index.toString().padLeft(2, '0')),
                                      onChanged: (value) {
                                        selectedMinute = value;
                                      }),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  if (patient.selectedTreatment.isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Center(
                                                child: AppText(
                                                    text: 'Check it Out',
                                                    textColor:
                                                        ColorPallete.themeColor,
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium),
                                              ),
                                              content: AppText(
                                                  text:
                                                      'Please select atleast one treatment ',
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall),
                                              actions: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: AppText(
                                                    text: 'Cancel',
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                    textColor:
                                                        ColorPallete.errorColor,
                                                  ),
                                                )
                                              ],
                                            ));
                                  } else if (formKey.currentState!.validate()) {
                                    context
                                        .read<RegisterPatientViewModel>()
                                        .registerPatient(
                                            name: usernameController.text,
                                            executive: "test_user",
                                            payment: payment,
                                            phone: phoneController.text,
                                            address: addressController.text,
                                            totalAmount: double.parse(
                                                totalAmountController.text),
                                            discountAmount: double.parse(
                                                discountAmountController.text),
                                            advanceAmount: double.parse(
                                                advanceAmountController.text),
                                            balanceAmount: double.parse(
                                                balanceAmountController.text),
                                            dateTime: getDateTime(
                                                selectedDate!,
                                                int.parse(selectedHour!),
                                                int.parse(selectedMinute!)),
                                            male: patient.selectedTreatment
                                                .map(
                                                    (data) => data.treatment.id)
                                                .toList(),
                                            female: patient.selectedTreatment
                                                .map(
                                                    (data) => data.treatment.id)
                                                .toList(),
                                            treatments: patient
                                                .selectedTreatment
                                                .map((data) => data.treatment.id)
                                                .toList(),
                                            branch: getBranch(selectedBranches!))
                                        .then((value) {
                                      if (patient.isError == true &&
                                          patient.isLoading == false) {
                                        ScaffoldMessenger.of(context)
                                          ..hideCurrentSnackBar()
                                          ..showSnackBar(SnackBar(
                                              content: AppText(
                                            text: patient.error ?? "",
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                            textColor: ColorPallete.whiteColor,
                                          )));
                                      } else {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            Routers.homeScreen,
                                            (listen) => false);
                                      }
                                    });
                                    ;
                                  }
                                },
                                child: patient.isLoading == true
                                    ? const CircularProgressIndicator(
                                        color: ColorPallete.whiteColor,
                                      )
                                    : AppText(
                                        text: 'Save',
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                        textColor: ColorPallete.whiteColor,
                                      ))
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )));
    });
  }
}
