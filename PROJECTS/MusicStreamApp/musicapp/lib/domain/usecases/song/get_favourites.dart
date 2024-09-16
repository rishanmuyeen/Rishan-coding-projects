import 'package:dartz/dartz.dart';
import 'package:musicapp/core/usecase/usecase.dart';
import 'package:musicapp/domain/repositories/song/song.dart';
import 'package:musicapp/service_locator.dart';


class GetFavoriteSongsUseCase implements UseCase<Either,dynamic> {

  @override
  Future<Either> call({params}) async{
    return await sl<SongRepository>().getFavouriteSongs();
  }
}