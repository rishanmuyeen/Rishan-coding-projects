
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/domain/entities/songs/song.dart';
import 'package:musicapp/domain/usecases/song/get_favourites.dart';
import 'package:musicapp/presentation/song_player/bloc/favourite_song_state.dart';
import 'package:musicapp/service_locator.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsLoading());
  
  
  List<SongEntity> favoriteSongs = [];

  Future<void> getFavoriteSongs() async {
   
   var result  = await sl<GetFavoriteSongsUseCase>().call();
   
   result.fold(
    (l){
      emit(
        FavoriteSongsFailure()
      );
    },
    (r){
      favoriteSongs = r;
      emit(
        FavoriteSongsLoaded(favoriteSongs: favoriteSongs)
      );
    }
  );
}

 void removeSong(int index) {
   favoriteSongs.removeAt(index);
   emit(
     FavoriteSongsLoaded(favoriteSongs: favoriteSongs)
   );
 }

}
