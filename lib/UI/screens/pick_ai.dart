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

class PickAi extends StatelessWidget {
  const PickAi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TicAppCubit, AppState>(
      builder: (context, state) {
        TicAppCubit cubit = TicAppCubit().get(context);
        return SafeArea(
          child: Scaffold(
            // backgroundColor: Colors.white,
            body: WrapperContainer(
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: form,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (cubit.isEnabled) {
                              SoundService(sound: 'sounds/click.mp3')
                                  .playSound();
                            }
                            playerXController.clear();
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.home,
                            color: MyColor.kWhitish,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Text(
                          'Enter Your Name',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          height: 4.h,
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
                          height: 4.h,
                        ),
                        Btn(
                          onTap: () {
                            if (form.currentState!.validate()) {
                              if (cubit.isEnabled) {
                                SoundService(sound: 'sounds/click.mp3')
                                    .playSound();
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GamePage(
                                      playerXName: playerXController.text,
                                      playerOName: 'Easy AI',
                                      isAgainstAI: true,
                                      levelsAI: 'EASY',
                                    ),
                                  ));
                            }
                          },
                          color: Colors.white,
                          height: 40,
                          width: 250,
                          borderRadius: 250,
                          child: Text(
                            "Easy mode".toUpperCase(),
                            style: TextStyle(
                                color: Colors.black.withOpacity(.8),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Btn(
                          onTap: () {
                            if (form.currentState!.validate()) {
                              if (cubit.isEnabled) {
                                SoundService(sound: 'sounds/click.mp3')
                                    .playSound();
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GamePage(
                                      playerXName: playerXController.text,
                                      playerOName: 'MEDIUM AI',
                                      isAgainstAI: true,
                                      levelsAI: 'MEDIUM',
                                    ),
                                  ));
                            }
                          },
                          color: Colors.white,
                          height: 40,
                          width: 250,
                          borderRadius: 250,
                          child: Text(
                            "MEDIUM mode".toUpperCase(),
                            style: TextStyle(
                                color: Colors.black.withOpacity(.8),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Btn(
                          onTap: () {
                            if (form.currentState!.validate()) {
                              if (cubit.isEnabled) {
                                SoundService(sound: 'sounds/click.mp3')
                                    .playSound();
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GamePage(
                                      playerXName: playerXController.text,
                                      playerOName: 'Hard AI',
                                      isAgainstAI: true,
                                      levelsAI: 'HARD',
                                    ),
                                  ));
                            }
                          },
                          color: Colors.white,
                          height: 40,
                          width: 250,
                          borderRadius: 250,
                          child: Text(
                            "Hard mode".toUpperCase(),
                            style: TextStyle(
                                color: Colors.black.withOpacity(.8),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
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
