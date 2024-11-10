import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/local/prefs_helper.dart';
import 'package:trendista_e_commerce/core/styles.dart';
import 'package:trendista_e_commerce/core/utils/routes_manager.dart';
import 'package:trendista_e_commerce/di/di.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_buttom.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_text_form_field.dart';
import 'package:trendista_e_commerce/presentation/ui/sign_in/sign_in_viewModel.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController emailController;

  late TextEditingController passwordController;

  SignInViewModel viewModel = getIt<SignInViewModel>();

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10, top: 128),
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
                    height: 60.h,
                  ),
                  Text(
                    'Welcome Back To Trendista',
                    style: Styles.textStyle24(context)
                        .copyWith(color: Colors.white),
                  ),
                  Text('Please sign in with your email',
                      style: Styles.textStyle16(context)),
                  SizedBox(
                    height: 25.h,
                  ),
                  CustomTextFormField(
                    formFieldTitle: 'E-mail',
                    hintText: 'enter your e-mail',
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'Please Enter your e-mail';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    formFieldTitle: 'Password',
                    hintText: 'enter your password',
                    isPassword: true,
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'Please Enter your password';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 9, bottom: 10),
                    child: Text(
                      'Forgot Password',
                      style: Styles.textStyle16(context),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  BlocConsumer<SignInViewModel, SignInViewModelState>(
                    bloc: viewModel,
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        ));
                      }
                      return CustomButtom(
                        buttonTitle: 'Login',
                        onButtonClicked: () {
                          logIn();
                        },
                      );
                    },
                    listener: (context, state) async {
                      if (state is ErrorState) {
                        Fluttertoast.showToast(
                            msg: state.errorMessage,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                      if (state is SuccessState) {
                        // Wait for the token to be saved before proceeding
                        // final bool tokenSaved = await PrefsHelper.setToken(
                        //     state.authEntity.data?.token ?? '');
                        final tokenSaved = PrefsHelper.getToken();
                        if (tokenSaved != null) {
                          Fluttertoast.showToast(
                              msg: "Logged in Successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Navigator.pushReplacementNamed(
                              context, RoutesManager.homeRouteName);
                        } else {
                          // Handle the token not being saved, if needed
                          Fluttertoast.showToast(
                              msg: "Failed to save token",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }
                    },
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RoutesManager.signUpRouteName);
                    },
                    child: Text(
                      "Don't have an account? Create Account",
                      style: Styles.textStyle18(context)
                          .copyWith(color: Colors.white),
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

  void logIn() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    await viewModel.signIn(
        email: emailController.text, password: passwordController.text);
  }
}
