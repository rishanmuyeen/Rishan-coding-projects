import 'package:dartz/dartz.dart';
import 'package:musicapp/data/models/auth/create_user.dart';
import 'package:musicapp/data/models/auth/signin_user.dart';

abstract class AuthRepository{
  Future<Either> signup(CreateUser create_user);
  Future<Either> signin(SigninUser signin_user);
  Future<Either> getUserInfor();

} 