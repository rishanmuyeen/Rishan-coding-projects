import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/common/bloc/favourite_button/favourite_button_state.dart';
import 'package:musicapp/domain/usecases/song/add_or_reomve_favourites.dart';
import 'package:musicapp/service_locator.dart';

class FavouriteButtonCubit extends Cubit<FavouriteButtonState> {
  FavouriteButtonCubit() : super(FavouriteButtonInitial());
  
  void favouriteButtonUpdated(String songId) async {
    var result = await sl<AddOrReomveFavouritesUseCase>().call(
      params: songId,
    );
    result.fold(
      (l) {
        // Handle error if needed
      },
      (isFavourite) {
        // Emit the new state with the updated favorite status
        emit(FavouriteButtonUpdated(isFavourite: isFavourite));
      },
    );
  }
}
