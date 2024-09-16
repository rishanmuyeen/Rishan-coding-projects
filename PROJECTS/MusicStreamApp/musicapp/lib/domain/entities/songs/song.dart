import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity{
  final String title;
  final String artist;
  final num duration;
  final Timestamp releasedate;
  final bool isFavourite;
  final String songId;

  SongEntity({required this.title, required this.artist, required this.duration, required this.releasedate,required this.isFavourite,required this.songId  });

} 