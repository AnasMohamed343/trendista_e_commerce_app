import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/styles.dart';
import 'package:trendista_e_commerce/core/utils/email_validation.dart';
import 'package:trendista_e_commerce/core/utils/image_functions.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/profile_tab/profile_tab_vm.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_buttom.dart';
import 'package:trendista_e_commerce/presentation/ui/home/widgets/custom_text_form_field.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController mobileNumberController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  //ProfileTabVM viewModel = getIt<ProfileTabVM>();
  late ProfileTabVM viewModel;
  Uint8List? pickedImage;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<ProfileTabVM>();
    viewModel.getProfileData();
    viewModel.stream.listen((state) {
      if (state is SuccessState) {
        fullNameController.text = state.userProfileEntity?.name ?? '';
        mobileNumberController.text = state.userProfileEntity?.phone ?? '';
        emailController.text = state.userProfileEntity?.email ?? '';
      }
    });
  }
  //
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   fullNameController.dispose();
  //   mobileNumberController.dispose();
  //   emailController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Edit Profile', style: Styles.textStyle24(context)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: w * 0.05,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(
            end: w * 0.04, start: w * 0.04, top: h * 0.06),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Consumer<ProfileTabVM>(builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: w * 0.17,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: pickedImage != null
                            ? Image.memory(pickedImage!).image
                            : Image.network(
                                    viewModel.userProfileEntity?.image ?? '')
                                .image,
                        child: pickedImage != null ||
                                viewModel.userProfileEntity?.image != null
                            ? null
                            : Icon(Icons.person, size: w * 0.16),
                      ),
                      SizedBox(
                        height: h * 0.03,
                      ),

                      // viewModel.userProfileEntity?.image != null
                      //     ? Image.network(
                      //         viewModel.userProfileEntity?.image ?? '',
                      //         fit: BoxFit.cover,
                      //       )
                      //     : SvgPicture.asset(
                      //         AssetsManager.profileIcon,
                      //         color: kPrimaryColor,
                      //         height: 70,
                      //         width: 70,
                      //       )
                      Positioned(
                        right: w * 0.02,
                        bottom: h / 10,
                        child: InkWell(
                          onTap: () {
                            //open
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: h * 0.2,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Text(
                                        'Pick Profile Image',
                                        style: Styles.textStyle20(context)
                                            .copyWith(color: kPrimaryColor),
                                      ),
                                      SizedBox(
                                        height: h * 0.02,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomButton(
                                              icon: Icons.camera_alt_outlined,
                                              buttonText: 'Camera',
                                              buttonColor: kPrimaryColor,
                                              buttonTextColor: Colors.white,
                                              onTap: () async {
                                                Uint8List? temp =
                                                    await ImageFunctions
                                                        .cameraPicker();
                                                if (temp != null) {
                                                  pickedImage = temp;
                                                  setState(() {});
                                                }
                                                Navigator.pop(context);
                                              }),
                                          CustomButton(
                                              icon: Icons.image_outlined,
                                              buttonText: 'Gallery',
                                              buttonColor: kPrimaryColor,
                                              buttonTextColor: Colors.white,
                                              onTap: () async {
                                                Uint8List? temp =
                                                    await ImageFunctions
                                                        .galleryPicker();
                                                if (temp != null) {
                                                  pickedImage = temp;
                                                  setState(() {});
                                                }
                                                Navigator.pop(context);
                                              }),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            height: h * 0.06,
                            width: w * 0.06,
                            decoration: const BoxDecoration(
                              color: kPrimaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              viewModel.userProfileEntity?.image == null
                                  ? Icons.camera_alt
                                  : Icons.edit,
                              color: Colors.white,
                              size: w * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomTextFormField(
                    borderSideColor: kBorderColor,
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
                    suffixIcon:
                        Icon(Icons.edit, color: kPrimaryColor, size: w * 0.05),
                  ),
                  CustomTextFormField(
                    borderSideColor: kBorderColor,
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
                    suffixIcon:
                        Icon(Icons.edit, color: kPrimaryColor, size: w * 0.05),
                  ),
                  CustomTextFormField(
                    borderSideColor: kBorderColor,
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
                    suffixIcon:
                        Icon(Icons.edit, color: kPrimaryColor, size: w * 0.05),
                  ),
                  // CustomTextFormField(
                  //   formFieldTitle: 'Password',
                  //   hintText: 'enter your password',
                  //   isPassword: true,
                  //   //maxLength: 6,
                  //   keyboardType: TextInputType.visiblePassword,
                  //   controller: passwordController,
                  //   validator: (input) {
                  //     if (input == null || input.trim().isEmpty) {
                  //       return 'Please Enter your password';
                  //     }
                  //     if (input.length < 6) {
                  //       return 'password should be at least 6 char';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  SizedBox(
                    height: h * 0.02,
                  ),

                  CustomButtom(
                    buttonBackgroundColor: kPrimaryColor,
                    buttonTitleColor: Colors.white,
                    buttonTitle: 'Update Profile',
                    onButtonClicked: () {
                      editProfile();
                    },
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  void editProfile() {
    final w = MediaQuery.of(context).size.width;
    if (formKey.currentState?.validate() == false) {
      return;
    }
    try {
      String imageToUpdate = pickedImage != null
          ? base64Encode(pickedImage!)
          : viewModel.userProfileEntity?.image ?? '';
      //viewModel.userProfileEntity?.image = pickedImage?.path ?? '';
      viewModel.updateProfileData(
        name: fullNameController.text,
        mobileNumber: mobileNumberController.text,
        email: emailController.text,
        image: imageToUpdate,
      );
      Fluttertoast.showToast(
          msg: "Profile updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: w * 0.02);
      Navigator.pop(context);
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: w * 0.02);
      print(e);
    }
  }
}

class CustomButton extends StatelessWidget {
  String buttonText;
  Color? buttonColor;
  Color? buttonTextColor;
  Function() onTap;
  IconData? icon;
  Size? buttonSize;
  Widget? iconWidget;
  CustomButton({
    required this.buttonText,
    this.buttonColor,
    this.buttonTextColor,
    required this.onTap,
    this.icon,
    this.buttonSize,
    this.iconWidget,
  });
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: w * 0.02, end: w * 0.01, start: w * 0.01, bottom: w * 0.02),
      child: Column(
        children: [
          Icon(
            icon,
            color: kPrimaryColor,
            size: w * 0.06,
          ),
          SizedBox(height: h * 0.01),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: buttonSize ?? Size(w * 0.9, h * 0.06),
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                onTap();
              },
              child: Text(
                buttonText,
                style: Styles.textStyle18(context).copyWith(
                  color: buttonTextColor,
                ),
              )),
        ],
      ),
    );
  }
}
