import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../Shared/components/wrapper_container.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../widgets/logo.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TicAppCubit, AppState>(
      builder: (context, state) {
        TicAppCubit cubit = TicAppCubit().get(context);
        Future.delayed(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              )),
        );
        return const Scaffold(
          body: WrapperContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tic Tac",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 65,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'DancingScript',
                  ),
                ),
                Logo(),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
