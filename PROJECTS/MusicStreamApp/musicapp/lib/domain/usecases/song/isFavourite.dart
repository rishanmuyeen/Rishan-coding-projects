import 'package:musicapp/core/usecase/usecase.dart';
import 'package:musicapp/domain/repositories/song/song.dart';
import 'package:musicapp/service_locator.dart';


class IsfavouriteUseCase implements UseCase<bool,String> {
  @override
  Future<bool> call({String? params}) async {
   return await sl<SongRepository>().isFavouriteSong(params!); 
  }

  
} 