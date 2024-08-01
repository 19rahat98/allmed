import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/bottom_navigation/app_bottom_navigation.dart';
import 'package:allmed/common/presentation/widgets/app_logo_animation_widget.dart';
import 'package:allmed/feature/auth/presentation/account_info/ui/set_account_info_screen.dart';
import 'package:allmed/feature/auth/presentation/global_auth/cubit/global_auth_cubit.dart';
import 'package:allmed/feature/auth/presentation/sign_up_number/ui/sign_up_number_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSplashScreen extends StatelessWidget {
  const AppSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalAuthCubit, CoreState>(
      listener: (context, state) {
        if (state is GlobalFinishAuthState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const SetAccountInfoBuilder(),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is GlobalSuccessAuthState) {
          return const AppBottomNavigation();
        } else if (state is GlobalAuthLogOutState || state is GlobalAuthStartState) {
          return const SignupNumberBuilder();
        }

        return const Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: LogoAnimationWidget(),
          ),
        );
      },
    );
  }
}
