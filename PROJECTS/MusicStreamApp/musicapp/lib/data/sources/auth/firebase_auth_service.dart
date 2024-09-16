import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicapp/core/configs/contants/app_urls.dart';
import 'package:musicapp/data/models/auth/create_user.dart';
import 'package:musicapp/data/models/auth/signin_user.dart';
import 'package:musicapp/data/models/auth/user.dart';
import 'package:musicapp/domain/entities/auth/user.dart';

abstract class AuthFirebaseServices{
  Future<Either> signup(CreateUser create_user);
  Future<Either> signin(SigninUser signin_user);
  Future<Either> getUserInfor();
}

class AuthFirebaseServiceImple extends AuthFirebaseServices{
   @override
  Future<Either> signin(SigninUser signin_user ) async { 
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signin_user.email,
        password: signin_user.password,
      );
      return Right("SignIn was successful");
    } catch (e) {
      String message = '';

      // Catch the Firebase-specific exception
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-credenials':
            message = 'The password is wrong.';
            break;
          case 'invalid-email':
            message = 'The user email is not found!.';
            break;
          default:
            message = 'An unknown error occurred.';
            break;
        }
      } else {
        // For other types of exceptions
        message = 'An unexpected error occurred.';
      }

      return Left(message); 
    }
  }


  @override
  Future<Either<String, String>> signup(CreateUser create_user) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: create_user.email,
        password: create_user.password,
      );
      FirebaseFirestore.instance.collection('users').doc(data.user?.uid).set(
        {
          'name' : create_user.fullname ,
          'email' : data.user?.email,
        }
      );
      return Right("Signup was successful");
    } catch (e) {
      String message = '';

      // Catch the Firebase-specific exception
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'weak-password':
            message = 'The password provided is too weak.';
            break;
          case 'email-already-in-use':
            message = 'The account already exists for that email.';
            break;
          case 'invalid-email':
            message = 'The email address is not valid.';
            break;
          default:
            message = 'An unknown error occurred.';
            break;
        }
      } else {
        // For other types of exceptions
        message = 'An unexpected error occurred.';
      }

      return Left(message); 
    }
  }
  
  @override
  Future<Either> getUserInfor() async {
    try{
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore.collection('users').doc(
        firebaseAuth.currentUser?.uid
      ).get(); 

      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.imageUrl = firebaseAuth.currentUser?.photoURL ?? AppUrls.defaultpic;
      UserEntity userEntity= userModel.toEntity();
      return Right(userEntity);
    }catch(e){
      return Left(e);
    }
  }
}  