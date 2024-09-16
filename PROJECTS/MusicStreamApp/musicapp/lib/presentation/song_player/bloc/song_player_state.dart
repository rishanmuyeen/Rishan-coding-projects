abstract class SongPlayerState {}

class SongPlayerLoading extends SongPlayerState{}
class SongPlayerLoaded extends SongPlayerState{
  final Duration songDuration;
  final Duration songPosition;
  final bool isPlaying;
  SongPlayerLoaded(this.songDuration, this.songPosition, this.isPlaying);
}
class SongPlayerFailure extends SongPlayerState{}

