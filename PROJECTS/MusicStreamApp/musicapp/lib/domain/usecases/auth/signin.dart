import 'package:dartz/dartz.dart';
import 'package:musicapp/core/usecase/usecase.dart';
import 'package:musicapp/data/models/auth/signin_user.dart';
import 'package:musicapp/domain/repositories/auth/auth.dart';
import 'package:musicapp/service_locator.dart';

class SigninUseCase implements UseCase<Either,SigninUser> {
  @override
  Future<Either> call({SigninUser? params}) {
    return sl<AuthRepository>().signin(params!); 
  }
}