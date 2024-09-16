import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musicapp/domain/entities/songs/song.dart';

class SongModel{
  String? title;
  String? artist;
  num? duration;
  Timestamp? releasedate;
  bool? isFavourite;
  String? songId;

  SongModel({required this.title, required this.artist, required this.duration, required this.releasedate, required this.isFavourite,required this.songId});

  SongModel.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    artist = data['artist'];
    duration = data['duration'];
    releasedate = data['releasedate'];
  }
}  
extension SongModelX on SongModel{
  SongEntity toEntity(){
    return SongEntity(
      title: title!, 
      artist: artist!, 
      duration: duration!, 
      releasedate: releasedate!,
      isFavourite: isFavourite!,
      songId : songId!
    );
  } 
}
