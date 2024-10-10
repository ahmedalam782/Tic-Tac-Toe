import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'Shared/bloc_observer/bloc_observer.dart';

import 'UI/cubit/cubit.dart';
import 'UI/cubit/state.dart';
import 'UI/screens/splash_screen.dart';
import 'network/local/cache_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const SimpleBlocObserver();
  await CacheHelper.init();
  bool? isPlay = CacheHelper.getData(key: 'isEnabled');
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(XOGameApp(
    isPlay: isPlay,
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class XOGameApp extends StatelessWidget {
  const XOGameApp({super.key, this.isPlay});

  final bool? isPlay;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicAppCubit()..playAppSound(forShared: isPlay),
      child: BlocConsumer<TicAppCubit, AppState>(
        builder: (context, state) {
          return Sizer(
              builder: (context, orientation, deviceType) => MaterialApp(
                    title: 'XO Game',
                    theme: ThemeData(
                      fontFamily: GoogleFonts.permanentMarker().fontFamily,
                    ),
                    debugShowCheckedModeBanner: false,
                    home: const SplashScreen(),
                  ));
        },
        listener: (context, state) {},
      ),
    );
  }
}
