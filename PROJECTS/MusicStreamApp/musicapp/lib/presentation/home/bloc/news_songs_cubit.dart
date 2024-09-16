import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/domain/usecases/song/get_new_songs.dart';
import 'package:musicapp/presentation/home/bloc/news_songs_state.dart';
import 'package:musicapp/service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {

  NewsSongsCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    var returnedSongs = await sl<GetNewsSongsUseCase>().call();
    returnedSongs.fold(
      (l) {
        emit(NewsSongsLoadFailure());
      },
      (data) {
        print('Songs data in cubit: $data'); // Check the data being emitted
        emit(NewsSongsLoaded(songs: data));
      }
    );
  }
}
  
