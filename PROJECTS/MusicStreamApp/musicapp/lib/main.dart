import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:musicapp/core/configs/theme/appTheme.dart';
import 'package:musicapp/firebase_options.dart';
import 'package:musicapp/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:musicapp/presentation/splash/pages/splash.dart';
import 'package:musicapp/service_locator.dart';
import 'package:path_provider/path_provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
      ? HydratedStorage.webStorageDirectory
      : await getApplicationDocumentsDirectory(),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await IntializeDependencies(); 
  runApp(const MyApp());
}  


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider (
      providers: [
        BlocProvider(create: (_) => ThemeCubit())
      ],
      child: BlocBuilder<ThemeCubit,ThemeMode>(
        builder: (context,mode) => 
        MaterialApp(
          title: 'Spotify App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: mode,
          debugShowCheckedModeBanner: false,
          home: SplashPage(),
        ),
      ),
    );
  }
}

