import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../Shared/themes/color.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

void showThemeBottomSheet(BuildContext context, Widget child, Color color) {
  showModalBottomSheet(
    context: context,
    backgroundColor: color,
    builder: (buildContext) => child,
  );
}

class SoundBottomSheet extends StatelessWidget {
  const SoundBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TicAppCubit, AppState>(
      builder: (context, state) {
        TicAppCubit cubit = TicAppCubit().get(context);
        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: MyColor.kBackground,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Enable Sound',
                    style: TextStyle(fontSize: 20, color: MyColor.kWhitish),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Switch(
                      inactiveThumbColor: MyColor.kPurple,
                      activeColor: MyColor.kBackground,
                      inactiveTrackColor: MyColor.kWhitish,
                      activeTrackColor: MyColor.kWhitish,
                      value: cubit.isEnabled,
                      onChanged: (value) => cubit.playAppSound(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
