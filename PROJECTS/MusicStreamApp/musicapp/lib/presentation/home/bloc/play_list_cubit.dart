import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/domain/usecases/song/get_play_list.dart';
import 'package:musicapp/presentation/home/bloc/play_list_state.dart';
import 'package:musicapp/service_locator.dart';

class PlayListCubit extends Cubit<PlayListState> {

  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    var returnedSongs = await sl<GetPlayListUseCase>().call();
    returnedSongs.fold(
      (l) {
        emit(PlayListLoadFailure());
      },
      (data) {
        print('Songs data in cubit: $data'); // Check the data being emitted
        emit(PlayListLoaded(songs: data));
      }
    );
  }
}
  
