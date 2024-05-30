import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:tic_tac_toe_xo_game/UI/screens/pick_ai.dart';
import 'package:tic_tac_toe_xo_game/UI/screens/players_names_screen.dart';

import '../../Shared/components/custom_btn.dart';
import '../../Shared/components/wrapper_container.dart';
import '../../Shared/services/sound.dart';
import '../../Shared/themes/color.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../widgets/bottomsheet_widget.dart';
import '../widgets/history_list.dart';
import '../widgets/logo.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'HomeScreen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TicAppCubit, AppState>(
      builder: (context, state) {
        TicAppCubit cubit = TicAppCubit().get(context);
        return SafeArea(
          child: WrapperContainer(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    const Center(child: Logo()),
                    SizedBox(
                      height: 20.h,
                    ),
                    Btn(
                      onTap: () {
                        if (cubit.isEnabled) {
                          SoundService(sound: 'sounds/click.mp3').playSound();
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PickAi(),
                            ));
                      },
                      height: 40,
                      width: 250,
                      borderRadius: 250,
                      color: Colors.white,
                      child: Text(
                        "single-player mode ".toUpperCase(),
                        style: TextStyle(
                          color: Colors.black.withOpacity(.8),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Btn(
                      onTap: () {
                        if (cubit.isEnabled) {
                          SoundService(sound: 'sounds/click.mp3').playSound();
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PlayersNamesScreen(),
                            ));
                      },
                      color: Colors.white,
                      height: 40,
                      width: 250,
                      borderRadius: 250,
                      child: Text(
                        "two-player mode ".toUpperCase(),
                        style: TextStyle(
                            color: Colors.black.withOpacity(.8),
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Btn(
                          onTap: () {
                            if (cubit.isEnabled) {
                              SoundService(sound: 'sounds/click.mp3')
                                  .playSound();
                            }
                            showThemeBottomSheet(
                                context,
                                HistoryList(
                                  historyGame: cubit.historyGame,
                                ),
                                MyColor.kBackground);
                          },
                          color: Colors.white,
                          height: 50,
                          width: 50,
                          borderRadius: 25,
                          child: const Icon(Icons.history),
                        ),
                        Btn(
                          onTap: () {
                            if (cubit.isEnabled) {
                              SoundService(sound: 'sounds/click.mp3')
                                  .playSound();
                            }
                            showThemeBottomSheet(context,
                                const SoundBottomSheet(), MyColor.kBackground);
                          },
                          color: Colors.white,
                          height: 50,
                          width: 50,
                          borderRadius: 25,
                          child: const Icon(Icons.settings),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
