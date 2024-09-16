import 'package:dartz/dartz.dart';

abstract class SongRepository{
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addorRemoveFavSongs(String songId);
  Future<bool> isFavouriteSong(String songId);
  Future<Either> getFavouriteSongs();
} 