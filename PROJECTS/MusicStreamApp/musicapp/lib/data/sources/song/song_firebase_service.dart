import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicapp/data/models/song/song.dart';
import 'package:musicapp/domain/entities/songs/song.dart';
import 'package:musicapp/domain/usecases/song/isFavourite.dart';
import 'package:musicapp/service_locator.dart';

abstract class SongFirebaseService{
  Future<Either> getNewsSongs();
  Future<Either> getPlayList(); 
  Future<Either> addorRemoveFavSong(String songId);
  Future<bool> isFavouriteSong(String songId);
   Future<Either> getFavouriteSongs();
}
class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];
      // Fetch data from Firestore
      var data = await FirebaseFirestore.instance.collection('Songs')
        .orderBy('releasedate', descending: true)  // Ensure the field name is correct
        .limit(4)
        .get();
      print('Fetched data: ${data.docs.map((doc) => doc.data()).toList()}');  // Log the fetched documents
      // Parse each document into SongModel and log details
      for (var element in data.docs) {
        var documentData = element.data();
        // Log each document data for inspection 
        print('Document data: $documentData');
        var songModel = SongModel.fromJson(documentData);
        bool isFavourite = await sl<IsfavouriteUseCase>().call(params:element.reference.id );
        songModel.isFavourite = isFavourite; 
        songModel.songId = element.reference.id ;
        // Log the parsed fields from SongModel
        print('Parsed song model: Title: ${songModel.title}, Artist: ${songModel.artist}, Duration: ${songModel.duration}, Releasedate: ${songModel.releasedate}');
        // Convert SongModel to SongEntity and add to the list
        songs.add(songModel.toEntity());
      }
      // Log the final list of SongEntity objects
      songs.forEach((song) {
        print('Converted song entity: Title: ${song.title}, Artist: ${song.artist}, Duration: ${song.duration}, Releasedate: ${song.releasedate}');
      });
      // Return the list of songs wrapped in Right (success) of Either
      return Right(songs);
    } catch (e) {
      // Print the error and return Left (failure) of Either
      print('Error fetching songs: $e');
      return const Left('An error occurred, Please try again.');
    }
  }
  
  @override
  Future<Either> getPlayList()async {
    try {
      List<SongEntity> songs = [];
      // Fetch data from Firestore
      var data = await FirebaseFirestore.instance.collection('Songs')
        .get();
      print('Fetched data: ${data.docs.map((doc) => doc.data()).toList()}');  // Log the fetched documents
      // Parse each document into SongModel and log details
      for (var element in data.docs) {
        var documentData = element.data();
        // Log each document data for inspection
        print('Document data: $documentData');
        var songModel = SongModel.fromJson(documentData);
         bool isFavourite = await sl<IsfavouriteUseCase>().call(params:element.reference.id );
        songModel.isFavourite = isFavourite; 
        songModel.songId = element.reference.id ;
        // Log the parsed fields from SongModel
        print('Parsed song model: Title: ${songModel.title}, Artist: ${songModel.artist}, Duration: ${songModel.duration}, Releasedate: ${songModel.releasedate}');
        // Convert SongModel to SongEntity and add to the list
        songs.add(songModel.toEntity());
      }
      // Log the final list of SongEntity objects
      songs.forEach((song) {
        print('Converted song entity: Title: ${song.title}, Artist: ${song.artist}, Duration: ${song.duration}, Releasedate: ${song.releasedate}');
      });
      // Return the list of songs wrapped in Right (success) of Either
      return Right(songs);
    } catch (e) {
      // Print the error and return Left (failure) of Either
      print('Error fetching songs: $e');
      return const Left('An error occurred, Please try again.');
    }
  }
  
  @override
  Future<Either> addorRemoveFavSong(String songId) async {
    try{
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      late bool isFavourite;
      var user = firebaseAuth.currentUser!;
      String userid = user.uid;
      
      QuerySnapshot favouriteSongs = await  firebaseFirestore
      .collection('users')
      .doc(userid)
      .collection('Favourites')
      .where(
        'songId', isEqualTo: songId
      ).get();

      if(favouriteSongs.docs.isNotEmpty){
        await favouriteSongs.docs.first.reference.delete();
        isFavourite = false;
      }else{
        await firebaseFirestore
        .collection('users')
        .doc(userid)
        .collection('Favourites')
        .add(
          {
            'songId' : songId,
            'addedDate' : Timestamp.now()
          }
        );
        isFavourite = true;
      }
      return Right(isFavourite);
    }catch(e){
      return Left(e); 
    }
  }
  
  @override
  Future<bool> isFavouriteSong(String songId) async {
    try{
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var user = firebaseAuth.currentUser!;
      String userid = user.uid;      
      QuerySnapshot favouriteSongs = await  firebaseFirestore
      .collection('users')
      .doc(userid)
      .collection('Favourites')
      .where(
        'songId', isEqualTo: songId
      ).get();

      if(favouriteSongs.docs.isNotEmpty){
        return true;
      }else{
       return false;
      }
    }catch(e){
      return false;
    }
  }
  
  @override
  Future<Either> getFavouriteSongs() async {
    try{
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var user = firebaseAuth.currentUser!;
      List<SongEntity> favouriteSongs = [];
      String userid = user.uid; 
      QuerySnapshot favouriteSnapshot = await firebaseFirestore
      .collection(
        'users'
      )
      .doc(userid)
      .collection('Favourites').get();

      for (var element in favouriteSnapshot.docs) { 
        String songId = element['songId'];
        var song = await firebaseFirestore.collection('Songs').doc(songId).get();
        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.isFavourite = true;
        songModel.songId = songId;
        favouriteSongs.add(
          songModel.toEntity()
        );
      }
      return Right(favouriteSongs);
    }catch(e){
      return Left(e); 
    }
  }
}

