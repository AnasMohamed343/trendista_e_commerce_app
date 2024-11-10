import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/local/prefs_helper.dart';
import 'package:trendista_e_commerce/core/styles.dart';
import 'package:trendista_e_commerce/core/utils/assets_manager.dart';
import 'package:trendista_e_commerce/core/utils/routes_manager.dart';
import 'package:trendista_e_commerce/di/di.dart';
import 'package:trendista_e_commerce/domain/entities/auth_entity/AuthEntity.dart';
import 'package:trendista_e_commerce/domain/entities/auth_entity/UserEntity.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/profile_tab/edit_profile.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/profile_tab/profile_tab_vm.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  //var viewModel = getIt<ProfileTabVM>();
  late ProfileTabVM viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<ProfileTabVM>()..getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: h * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<ProfileTabVM, ProfileState>(
                  bloc: viewModel,
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case LoadingState:
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: h * 0.1),
                            child: const CircularProgressIndicator(),
                          ),
                        );
                      case ErrorState:
                        final errorState = state as ErrorState;
                        return Center(
                          child: Text(
                              errorState.errorMessage ?? 'Error loading data'),
                        );
                      case SuccessState:
                        final successState = state as SuccessState;
                        return Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                            vertical: h * 0.02,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                      radius: w * 0.15,
                                      backgroundColor: Colors.grey.shade200,
                                      backgroundImage: successState
                                                  .userProfileEntity?.image !=
                                              null
                                          ? Image.network(
                                              successState.userProfileEntity
                                                      ?.image ??
                                                  '',
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Image.asset(
                                                AssetsManager.profileIcon,
                                              ),
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return const Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(30),
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                );
                                              },
                                            ).image
                                          : null,
                                      child:
                                          successState.userProfileEntity == null
                                              ? SvgPicture.asset(
                                                  AssetsManager.profileIcon,
                                                  color: kPrimaryColor,
                                                  height: h * 0.13,
                                                  width: w * 0.13,
                                                )
                                              : null),
                                ],
                              ),
                              SizedBox(height: h * 0.01),
                              Text(
                                successState.userProfileEntity?.name ?? 'user',
                                style: Styles.textStyle20(context).copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              //const SizedBox(height: 3),
                              Text(
                                successState.userProfileEntity?.email ??
                                    'user email',
                                style: Styles.textStyle16(context).copyWith(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              SizedBox(height: h * 0.005),
                              Text(
                                successState.userProfileEntity?.phone ??
                                    'user phone',
                                style: Styles.textStyle16(context).copyWith(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        );
                    }
                    return Container();
                  },
                ),
                // const Spacer(), // Push CircleAvatar to the bottom
                // // CircleAvatar with cart icon
                SizedBox(height: h * 0.02),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen()),
                    ).then((value) => viewModel.getProfileData());
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(AssetsManager.profileIcon,
                          color: kPrimaryColor,
                          height: h * 0.03,
                          width: w * 0.03),
                      SizedBox(width: w * 0.03),
                      Text('Edit Your Profile',
                          style: Styles.textStyle18(context)),
                      const Spacer(),
                      Icon(Icons.arrow_forward_ios,
                          color: kPrimaryColor, size: w * 0.05),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Divider(
                    color: Colors.grey.shade200,
                    thickness: 1.5,
                    indent: 5,
                    endIndent: 5,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesManager.cartRouteName);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: kPrimaryColor,
                        size: w * 0.05,
                      ),
                      SizedBox(width: w * 0.03),
                      Text('Shopping Cart', style: Styles.textStyle18(context)),
                      const Spacer(),
                      Icon(Icons.arrow_forward_ios,
                          color: kPrimaryColor, size: w * 0.05),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Divider(
                    color: Colors.grey.shade200,
                    thickness: 1.5,
                    indent: 5,
                    endIndent: 5,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, RoutesManager.ordersScreenRouteName);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(AssetsManager.ordersIcon,
                          color: kPrimaryColor,
                          height: h * 0.03,
                          width: w * 0.03),
                      SizedBox(width: w * 0.03),
                      Text('My Orders', style: Styles.textStyle18(context)),
                      const Spacer(),
                      Icon(Icons.arrow_forward_ios,
                          color: kPrimaryColor, size: w * 0.05),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Divider(
                    color: Colors.grey.shade200,
                    thickness: 1.5,
                    indent: 5,
                    endIndent: 5,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.payment,
                      color: kPrimaryColor,
                      size: w * 0.05,
                    ),
                    SizedBox(width: w * 0.03),
                    Text('Payment Methods', style: Styles.textStyle18(context)),
                    const Spacer(),
                    Icon(Icons.arrow_forward_ios,
                        color: kPrimaryColor, size: w * 0.05),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Divider(
                    color: Colors.grey.shade200,
                    thickness: 1.5,
                    indent: 5,
                    endIndent: 5,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(AssetsManager.settingsIcon,
                        color: kPrimaryColor,
                        height: h * 0.03,
                        width: w * 0.03),
                    SizedBox(width: w * 0.03),
                    Text('Settings', style: Styles.textStyle18(context)),
                    const Spacer(),
                    Icon(Icons.arrow_forward_ios,
                        color: kPrimaryColor, size: w * 0.05),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Divider(
                    color: Colors.grey.shade200,
                    thickness: 1.5,
                    indent: 5,
                    endIndent: 5,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    logOut(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout_sharp,
                        color: kPrimaryColor,
                        size: w * 0.05,
                      ),
                      SizedBox(width: w * 0.03),
                      Text('Log Out', style: Styles.textStyle18(context)),
                      const Spacer(),
                      Icon(Icons.arrow_forward_ios,
                          color: kPrimaryColor, size: w * 0.05),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void logOut(context) {
    PrefsHelper.clearToken();
    Navigator.pushReplacementNamed(context, RoutesManager.signInRouteName);
  }
}
