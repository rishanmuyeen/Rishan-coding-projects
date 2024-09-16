 import 'package:dartz/dartz.dart';
import 'package:musicapp/core/usecase/usecase.dart';
import 'package:musicapp/domain/repositories/song/song.dart';
import 'package:musicapp/service_locator.dart';


class AddOrReomveFavouritesUseCase implements UseCase<Either,String> {
  @override
  Future<Either> call({String? params}) async {
   return await sl<SongRepository>().addorRemoveFavSongs(params!); 
  }

  
} 