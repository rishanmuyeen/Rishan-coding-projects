import 'package:dartz/dartz.dart';
import 'package:musicapp/data/sources/song/song_firebase_service.dart';
import 'package:musicapp/domain/repositories/song/song.dart';
import 'package:musicapp/service_locator.dart';

class SongRepoImple extends SongRepository{
  @override
  Future<Either> getNewsSongs()async {
    return await sl<SongFirebaseService>().getNewsSongs();
  }
  
  @override
  Future<Either> getPlayList() async  {
    return await sl<SongFirebaseService>().getPlayList();
  }
  
  @override
  Future<Either> addorRemoveFavSongs(String songId) async {
    return await sl<SongFirebaseService>().addorRemoveFavSong(songId);

  }
  
  @override
  Future<bool> isFavouriteSong(String songId) async {
    return await sl<SongFirebaseService>().isFavouriteSong(songId);
  }
  
  @override
  Future<Either> getFavouriteSongs() async {
    return await sl<SongFirebaseService>().getFavouriteSongs();
  }

}