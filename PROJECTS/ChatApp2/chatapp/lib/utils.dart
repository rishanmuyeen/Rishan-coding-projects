import 'package:chatapp/services/alert_service.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/database_service.dart';
import 'package:chatapp/services/media_service.dart';
import 'package:chatapp/services/navigation_service.dart';
import 'package:chatapp/services/storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
 import 'package:chatapp/firebase_options.dart';
import 'package:get_it/get_it.dart';

Future<void> setupFirebase() async{
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
}

Future<void> RegisterServices() async{
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<AuthService>(
    AuthService()
  );
  getIt.registerSingleton<NavigationService>(
     NavigationService()
  ); 
  getIt.registerSingleton<AlertService>(
    AlertService()
  ); 
  getIt.registerSingleton<MediaService>(
    MediaService() 
  ); 
  getIt.registerSingleton<StorageService>(
    StorageService() 
  ); 
  getIt.registerSingleton<Database>(
    Database () 
  ); 

}