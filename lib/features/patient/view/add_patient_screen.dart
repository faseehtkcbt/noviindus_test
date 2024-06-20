import 'package:flutter/material.dart';
import 'package:noviindus_test/core/color_pallette/color_pallete.dart';
import 'package:noviindus_test/core/constants/constants.dart';
import 'package:noviindus_test/core/utils/app_drop_text_form.dart';
import 'package:noviindus_test/core/utils/app_text.dart';
import 'package:noviindus_test/core/utils/app_text_form.dart';
import 'package:noviindus_test/features/patient/view/widget/add_treatment_button.dart';
import 'package:noviindus_test/features/patient/view_model/branch_view_model.dart';
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BranchViewModel>().getBranches();
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
                              textStyle: Theme.of(context).textTheme.titleSmall),
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
                              textStyle: Theme.of(context).textTheme.titleSmall),
                          AppTextFormField(
                            controller: phoneController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              textStyle: Theme.of(context).textTheme.titleSmall),
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
                              textStyle: Theme.of(context).textTheme.titleSmall),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              textStyle: Theme.of(context).textTheme.titleSmall),
                          AddTreatmentButton(
                            addFunction: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      padding: const EdgeInsets.all(15),
                                      height: 450,
                                    );
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)));
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          AppText(
                              text: 'Total Amount',
                              textStyle: Theme.of(context).textTheme.titleSmall),
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
                              textStyle: Theme.of(context).textTheme.titleSmall),
                          AppTextFormField(
                            controller: discountAmountController,
                            hintText: 'Discount Amount',
                            readOnly: true,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          AppText(
                              text: 'Advance Amount',
                              textStyle: Theme.of(context).textTheme.titleSmall),
                          AppTextFormField(
                            controller: advanceAmountController,
                            hintText: 'Enter advance amount wish to pay',
                            textInputType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please specify a advance amount';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          AppText(
                              text: 'Balance Amount',
                              textStyle: Theme.of(context).textTheme.titleSmall),
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
                              textStyle: Theme.of(context).textTheme.titleSmall),
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
                                selectedDate = picked as DateTime?;
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
                              textStyle: Theme.of(context).textTheme.titleSmall),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: size.width * .45,
                                child: AppDropTextForm(
                                    hintText: 'Hour',
                                    dropDownList: List.generate(
                                        24, (index) => index.toString().padLeft(2, '0')),
                                    onChanged: (value) {
                                      selectedHour = value;
                                    }),
                              ),
                              SizedBox(
                                width: size.width * .45,
                                child: AppDropTextForm(
                                    hintText: 'Minute',
                                    dropDownList: List.generate(
                                        60, (index) => index.toString().padLeft(2, '0')),
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
                                if(formKey.currentState!.validate()){}
                              },
                              child: AppText(
                                text: 'Save',
                                textStyle:
                                    Theme.of(context).textTheme.titleMedium,
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
  }
}
