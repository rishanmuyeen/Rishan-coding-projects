import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicapp/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState>{
  
  AudioPlayer audioPlayer = AudioPlayer();

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super (SongPlayerLoading()){
    audioPlayer.positionStream.listen((position){
      songPosition = position;
      updateSongPlayer(); 
    });

    audioPlayer.durationStream.listen((duration){
      songDuration = duration!; 
    });
  }
  // void updateSongPlayer(){
  //   emit(
  //     SongPlayerLoaded()
  //   );
  // }
  void updateSongPlayer() {
    emit(
      SongPlayerLoaded(
        songDuration, // pass the duration
        songPosition, // pass the current position
        audioPlayer.playing // pass whether the song is playing or not
      )
    );
  }
  Future<void> loadSong(String url) async {
    try {
      await audioPlayer.setUrl(url); 
      songDuration = audioPlayer.duration ?? Duration.zero; // Capture song duration
      emit(SongPlayerLoaded(
        songDuration,
        songPosition,
        audioPlayer.playing
      )); 
    } catch (e) {
      emit(SongPlayerFailure());
    }
  }

  // Future<void> loadSong(String url) async {
  //   try{
  //     await audioPlayer.setUrl(url); 
  //     songDuration = audioPlayer.duration ?? Duration.zero; // Capture song duration
  //     emit(SongPlayerLoaded()); 
  //   }catch(e){
  //     emit(
  //       SongPlayerFailure()
  //     );
  //   }
  // }
  // void play_or_pause(){
  //   if(audioPlayer.playing){
  //     audioPlayer.pause();
  //   }else{
  //     audioPlayer.play();
  //   }
  //   emit(
  //     SongPlayerLoaded()
  //   );
  // }
  void play_or_pause() async {
    if (audioPlayer.playing) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play();
    }
    // Emit the updated state so the UI knows whether the song is playing or paused
    emit(SongPlayerLoaded(
      audioPlayer.duration ?? Duration.zero,
      audioPlayer.position,
      audioPlayer.playing
    ));
  }


  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
  void seek(Duration position) {
    audioPlayer.seek(position);
    emit(SongPlayerLoaded(
      audioPlayer.duration ?? Duration.zero,
      audioPlayer.position,
      audioPlayer.playing
    ));
  }
}