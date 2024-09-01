import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trendista_e_commerce/core/local/prefs_helper.dart';
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
        backgroundColor: Color(0xff004182),
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
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24.sp,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Please sign in with your email',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
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
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  BlocConsumer<SignInViewModel, SignInViewModelState>(
                    bloc: viewModel,
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return Center(
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
                      }
                      if (state is SuccessState) {
                        PrefsHelper.setToken(state.authEntity.token ?? '');
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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
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

  void logIn() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    viewModel.signIn(
        email: emailController.text, password: passwordController.text);
  }
}
