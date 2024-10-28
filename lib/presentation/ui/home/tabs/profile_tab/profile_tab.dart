import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/local/prefs_helper.dart';
import 'package:trendista_e_commerce/core/styles.dart';
import 'package:trendista_e_commerce/core/utils/routes_manager.dart';
import 'package:trendista_e_commerce/di/di.dart';
import 'package:trendista_e_commerce/domain/entities/auth_entity/AuthEntity.dart';
import 'package:trendista_e_commerce/domain/entities/auth_entity/UserEntity.dart';
import 'package:trendista_e_commerce/presentation/ui/home/tabs/profile_tab/profile_tab_vm.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  var viewModel = getIt<ProfileTabVM>();

  @override
  void initState() {
    super.initState();
    viewModel.getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ProfileTabVM, ProfileState>(
                bloc: viewModel,
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case LoadingState:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ErrorState:
                      final errorState = state as ErrorState;
                      return Center(
                        child: Text(
                            errorState.errorMessage ?? 'Error loading data'),
                      );
                    case SuccessState:
                      final successState = state as SuccessState;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, ${successState.authEntity?.name ?? 'user'}',
                            style: Styles.textStyle18.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '     ${successState.authEntity?.email ?? 'user email'}',
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 16),
                          ),
                        ],
                      );
                  }
                  return Container();
                },
              ),
              // const Spacer(), // Push CircleAvatar to the bottom
              // // CircleAvatar with cart icon
              const SizedBox(height: 35),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RoutesManager.cartRouteName);
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.green.shade800,
                      child: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Text('Shopping Cart', style: Styles.textStyle18),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  logOut(context);
                },
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.logout_sharp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text('Log Out', style: Styles.textStyle18),
                  ],
                ),
              ),
            ],
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
