import 'package:dartz/dartz.dart';
import 'package:musicapp/data/models/auth/create_user.dart';
import 'package:musicapp/data/models/auth/signin_user.dart';
import 'package:musicapp/data/sources/auth/firebase_auth_service.dart';
import 'package:musicapp/domain/repositories/auth/auth.dart';
import 'package:musicapp/service_locator.dart';

class AuthRepoImple extends AuthRepository{
  @override
  Future<Either > signin(SigninUser signin_user) async {
    return await sl<AuthFirebaseServices>().signin(signin_user); 
  }

  @override
  Future<Either> signup(CreateUser create_user ) async {
    return await sl<AuthFirebaseServices>().signup(create_user);
  }
  
  @override
  Future<Either> getUserInfor() async {
    return await sl<AuthFirebaseServices>().getUserInfor();
  }
}    