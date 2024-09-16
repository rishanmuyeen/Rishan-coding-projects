
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/domain/usecases/auth/get_user_info.dart';
import 'package:musicapp/presentation/profile/bloc/profile_info_state.dart';
import 'package:musicapp/service_locator.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {

  ProfileInfoCubit() : super (ProfileInfoLoading());

  Future<void> getUser() async {

    var user = await sl<GetUserInfoUseCase>().call();

    user.fold(
      (l){
        emit(
          ProfileInfoFailure()
        );
      }, 
      (userEntity) {
        emit(
          ProfileInfoLoaded(userEntity: userEntity)
        );
      }
    );
  }
}
