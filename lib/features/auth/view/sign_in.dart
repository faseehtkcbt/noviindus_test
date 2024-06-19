import 'package:flutter/material.dart';
import 'package:noviindus_test/core/constants/constants.dart';
import 'package:noviindus_test/core/utils/app_text.dart';
import 'package:noviindus_test/core/utils/app_text_form.dart';

import '../../../core/utils/email_validation.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final pswdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 25,right: 25),
        width: double.infinity,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [AppText(text: 'By creating or logging into an account you are agreeing', textStyle: Theme.of(context).textTheme.bodySmall),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(text: 'with our ', textStyle: Theme.of(context).textTheme.bodySmall,),
              AppText(text: 'Terms and Conditions', textStyle: Theme.of(context).textTheme.bodySmall,textColor: Colors.blueAccent,fontWeight: FontWeight.w500,),
              AppText(text: ' and ', textStyle: Theme.of(context).textTheme.bodySmall),
              AppText(text: 'Privacy Policy.', textStyle: Theme.of(context).textTheme.bodySmall,textColor: Colors.blueAccent,fontWeight: FontWeight.w500,),
            ],
            //Terms and Conditions
          )],
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                    children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppConstants.signInImage),
                      fit: BoxFit.fill)),
              child: Center(
                child: Image.asset(
                  AppConstants.logoImage,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: 'Login or register to book your appointments',
                      textStyle: Theme.of(context).textTheme.titleLarge,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppText(
                        text: 'Email',
                        textStyle: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(
                      height: 5,
                    ),
                    AppTextFormField(
                      controller: emailController,
                      hintText: 'Enter your email',
                      textInputType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter an email address";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppText(
                        text: 'Password',
                        textStyle: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(
                      height: 5,
                    ),
                    AppTextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter a password";
                          } else if (value.length < 8) {
                            return "Password must contain least 8 characters";
                          }
                          return null;
                        },
                        textInputType: TextInputType.visiblePassword,
                        isObscure: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: pswdController, hintText: 'Enter password'),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(onPressed: (){
                      if(formKey.currentState!.validate()){
                        
                      }
                    }, child:AppText(text: 'Login', textStyle: Theme.of(context).textTheme.titleMedium,textColor: Colors.white,))
                  ],
                ),
              ),
            )
                    ],
                  ),
          )),
    );
  }
}
