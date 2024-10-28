import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trendista_e_commerce/core/local/prefs_helper.dart';
import 'package:trendista_e_commerce/core/styles.dart';
import 'package:trendista_e_commerce/core/utils/email_validation.dart';
import 'package:trendista_e_commerce/core/utils/routes_manager.dart';
import 'package:trendista_e_commerce/di/di.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_buttom.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_text_form_field.dart';
import 'package:trendista_e_commerce/presentation/ui/sign_up/sign_up_viewModel.dart';

import '../../../constants.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController fullNameController;

  late TextEditingController mobileNumberController;

  late TextEditingController emailController;

  late TextEditingController passwordController;

  var formKey = GlobalKey<FormState>();

  SignUpViewModel viewModel = getIt<SignUpViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullNameController = TextEditingController(text: 'Anas Mohamed');
    mobileNumberController = TextEditingController(text: '01095915172');
    emailController = TextEditingController(text: 'anasmoo5@gmail.com');
    passwordController = TextEditingController(text: '010959');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        body: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10, top: 58),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Trendista',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.almendra(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 42.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      //fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  CustomTextFormField(
                    formFieldTitle: 'Full Name',
                    hintText: 'enter your full name',
                    keyboardType: TextInputType.text,
                    controller: fullNameController,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'Please Enter Valid Name';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    formFieldTitle: 'Mobile Number',
                    hintText: 'enter your mobile no.',
                    //maxLength: 11,
                    keyboardType: TextInputType.phone,
                    controller: mobileNumberController,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'Please Enter your Mobile Number';
                      }
                      if (input.length < 11) {
                        return 'mobile num should be at least 11 char';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    formFieldTitle: 'E-mail Address',
                    hintText: 'enter your email address.',
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'Please Enter your E-mail Address';
                      }
                      if (!isValidEmail(input)) {
                        return 'Invalid Email';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    formFieldTitle: 'Password',
                    hintText: 'enter your password',
                    isPassword: true,
                    //maxLength: 6,
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'Please Enter your password';
                      }
                      if (input.length < 6) {
                        return 'password should be at least 6 char';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  BlocConsumer<SignUpViewModel, SignUpViewModelState>(
                    bloc: viewModel,
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        ));
                      }
                      return CustomButtom(
                        buttonTitle: 'Sign Up',
                        onButtonClicked: () {
                          signUp();
                        },
                      );
                    },
                    listener: (context, state) {
                      if (state is ErrorState) {
                        Fluttertoast.showToast(
                            msg: state.errorMessage,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        return;
                      }
                      if (state is SuccessState) {
                        // PrefsHelper.setToken(
                        //     value: state.token, key: token ?? '');
                        print(state.token);
                        PrefsHelper.setToken(state.token);
                        Fluttertoast.showToast(
                            msg: "Registered Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.pushReplacementNamed(
                            context, RoutesManager.signInRouteName);
                      }
                    },
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RoutesManager.signInRouteName);
                    },
                    child: Text(
                      "Already have an account? Login",
                      style: Styles.textStyle18.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp() {
    if (formKey.currentState?.validate() == false) {
      return;
    }

    // now should sign up
    viewModel.signUp(
        email: emailController.text,
        password: passwordController.text,
        mobileNumber: mobileNumberController.text,
        name: fullNameController.text);
  }
}
