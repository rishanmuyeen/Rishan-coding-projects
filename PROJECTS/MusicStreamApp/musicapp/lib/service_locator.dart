import 'package:get_it/get_it.dart';
import 'package:musicapp/data/repositories/auth/auth_repo_imple.dart';
import 'package:musicapp/data/repositories/song/song_repo_imple.dart';
import 'package:musicapp/data/sources/auth/firebase_auth_service.dart';
import 'package:musicapp/data/sources/song/song_firebase_service.dart';
import 'package:musicapp/domain/repositories/auth/auth.dart';
import 'package:musicapp/domain/repositories/song/song.dart';
import 'package:musicapp/domain/usecases/auth/get_user_info.dart';
import 'package:musicapp/domain/usecases/auth/signin.dart';
import 'package:musicapp/domain/usecases/auth/signup.dart';
import 'package:musicapp/domain/usecases/song/add_or_reomve_favourites.dart';
import 'package:musicapp/domain/usecases/song/get_favourites.dart';
import 'package:musicapp/domain/usecases/song/get_new_songs.dart';
import 'package:musicapp/domain/usecases/song/get_play_list.dart';
import 'package:musicapp/domain/usecases/song/isFavourite.dart';

final sl =GetIt.instance;

Future<void> IntializeDependencies() async {
  sl.registerSingleton<AuthFirebaseServices>(
    AuthFirebaseServiceImple()
  );
  sl.registerSingleton<AuthRepository>(
    AuthRepoImple ()
  );
  sl.registerSingleton<SignupUseCase>(
    SignupUseCase()
  );
  sl.registerSingleton<SigninUseCase>(
    SigninUseCase()
  );
  sl.registerSingleton<SongFirebaseService>(
    SongFirebaseServiceImpl()
  );
  sl.registerSingleton<SongRepository>(
    SongRepoImple()
  );
  sl.registerSingleton<GetNewsSongsUseCase>(
    GetNewsSongsUseCase()
  );
  sl.registerSingleton<GetPlayListUseCase>(
    GetPlayListUseCase()
  );
  sl.registerSingleton<IsfavouriteUseCase>(
    IsfavouriteUseCase()
  );
  sl.registerSingleton<AddOrReomveFavouritesUseCase>(
    AddOrReomveFavouritesUseCase()
  );
  sl.registerSingleton<GetUserInfoUseCase>(
    GetUserInfoUseCase()
  );
  sl.registerSingleton<GetFavoriteSongsUseCase>(
    GetFavoriteSongsUseCase() 
  );
}  