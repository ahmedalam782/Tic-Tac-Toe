import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tic_tac_toe_xo_game/UI/cubit/state.dart';

import '../../Shared/game_logic/game_util.dart';
import '../../network/local/cache_helper.dart';

class TicAppCubit extends Cubit<AppState> {
  TicAppCubit() : super(AppInitialState());

  TicAppCubit get(context) => BlocProvider.of(context);
  bool isEnabled = false;
  late Database database;
  List<Map> historyGame = [];

  void playAppSound({bool? forShared}) {
    if (forShared != null) {
      isEnabled = forShared;
    } else {
      isEnabled = !isEnabled;
      CacheHelper.saveData(key: 'isEnabled', value: isEnabled)
          .then((value) => emit(PlayButtonSoundState()));
    }
    isPlaySound = isEnabled;
  }

}
