abstract class AppState {}

class AppInitialState extends AppState {}

class PlayButtonSoundState extends AppState {}

class AppCreateDataBaseState extends AppState {}

class AppInsertDataBaseState extends AppState {}

class AppGetDataBaseState extends AppState {}

class AppGetDataBaseLoadingState extends AppState {}

class AppDeleteDataBaseState extends AppState {}

class AppErrorDataBaseState extends AppState {
  final String error;

  AppErrorDataBaseState({required this.error});
}
