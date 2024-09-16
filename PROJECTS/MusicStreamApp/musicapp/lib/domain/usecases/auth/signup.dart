import 'package:dartz/dartz.dart';
import 'package:musicapp/core/usecase/usecase.dart';
import 'package:musicapp/data/models/auth/create_user.dart';
import 'package:musicapp/domain/repositories/auth/auth.dart';
import 'package:musicapp/service_locator.dart';

class SignupUseCase implements UseCase<Either,CreateUser> {
  @override
  Future<Either> call({CreateUser? params}) {
    return sl<AuthRepository>().signup(params!); 
  }
 
}