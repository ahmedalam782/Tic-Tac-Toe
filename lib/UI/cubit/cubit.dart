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

  void createDatabase() async {
    emit(AppGetDataBaseLoadingState());
    database = await openDatabase('XOGame.db',
        version: 1,
        onCreate: (database, version) => database
            .execute(
                'CREATE TABLE history_game(id INTEGER PRIMARY KEY ,player_x_name TEXT,player_o_name TEXT,player_x_score TEXT,player_o_score TEXT,draw_score TEXT,date TEXT)')
            .then((value) => log('table created'))
            .catchError((error) => log(error.toString())),
        onOpen: (database) {
          log('Database opened');
          getDataFromDatabase(database);
        }).then((value) {
      emit(AppCreateDataBaseState());
      return database = value;
    });
  }

  Future insertDatabase({
    required String playerXName,
    required String playerXScore,
    required String playerOName,
    required String playerOScore,
    required String drawScore,
    required String date,
  }) async {
    emit(AppGetDataBaseLoadingState());
    await database.transaction((txn) => txn
            .rawInsert(
                'INSERT INTO history_game(player_x_name,player_o_name,player_x_score,player_o_score,draw_score,date) VALUES("$playerXName","$playerOName","$playerXScore","$playerOScore","$drawScore","$date")')
            .then((value) {
          getDataFromDatabase(database);
          emit(AppInsertDataBaseState());
          log('$value Inserted Completed');
        }).catchError((error) {
          emit(AppErrorDataBaseState(error: error.toString()));
        }));
  }

  void getDataFromDatabase(database) {
    historyGame = [];
    database.rawQuery('SELECT * FROM history_game').then((value) {
      value.forEach((element) {
        historyGame.add(element);
      });
      emit(AppGetDataBaseState());
    }).catchError((error) {
      emit(AppErrorDataBaseState(error: error.toString()));
    });
  }

  void deleteDatabase({required int id}) async {
    database.rawUpdate('DELETE FROM history_game WHERE id=$id').then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDataBaseState());
    }).catchError((error) {
      emit(AppErrorDataBaseState(error: error.toString()));
    });
  }
}
