import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';


import '../../Shared/components/custom_btn.dart';
import '../../Shared/components/custom_text_form_field.dart';
import '../../Shared/components/wrapper_container.dart';
import '../../Shared/game_logic/game_util.dart';
import '../../Shared/services/sound.dart';

import '../../Shared/themes/color.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import 'game.dart';


class PlayersNamesScreen extends StatelessWidget {
  static const String routeName = 'PlayersNamesScreen';

  const PlayersNamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TicAppCubit, AppState>(
      builder: (context, state) {
        TicAppCubit cubit = TicAppCubit().get(context);
        return WrapperContainer(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Form(
                key: form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    IconButton(
                      onPressed: () {
                        if (cubit.isEnabled) {
                          SoundService(sound: 'sounds/click.mp3').playSound();
                        }
                        playerXController.clear();
                        playerOController.clear();
                        Navigator.pop(context);

                      },
                      icon: const Icon(
                        Icons.home,
                        color: MyColor.kWhitish,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    const Text(
                      'Enter Player Names',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    CustomTextFormField(
                      hintText: 'Player X',
                      isX: true,
                      controller: playerXController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Player X name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    CustomTextFormField(
                      hintText: 'Player O',
                      isX: false,
                      controller: playerOController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Player O name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Btn(
                      onTap: () {
                        if (form.currentState!.validate()) {
                          if (playerXController.text.toLowerCase().trim() ==
                              playerOController.text.toLowerCase().trim()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: MyColor.kForeground,
                                content: Text(
                                  'Please enter different names',
                                  style: TextStyle(
                                    color: MyColor.kWhitish,
                                  ),
                                ),
                              ),
                            );
                            return;
                          }
                          FocusScope.of(context).unfocus(
                              disposition:
                                  UnfocusDisposition.previouslyFocusedChild);
                          if (cubit.isEnabled) {
                            SoundService(sound: 'sounds/click.mp3').playSound();
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GamePage(
                                  playerXName: playerXController.text,
                                  playerOName: playerOController.text,
                                  isAgainstAI: false,
                                  levelsAI: '',
                                ),
                              ));
                        }
                      },
                      color: Colors.white,
                      height: 12.w,
                      width: double.infinity,
                      borderRadius: 3.w,
                      child: Text(
                        "Start Game".toUpperCase(),
                        style: TextStyle(
                            color: Colors.black.withOpacity(.8),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
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
