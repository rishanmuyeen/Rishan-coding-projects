import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? _user;

  User? get user {
    return _user;
  }

  AuthService(){
    firebaseAuth.authStateChanges().listen(AuthStateChangeStreamListner); 
  }

  Future<bool> signUp(String email,String password) async{
    try{
      final credentals = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if(credentals.user != null){
        _user = credentals.user; 
        return true;
      }
    }catch(e){
      print(e);
    }
    return false; 
  }
  Future<bool> login(String email,String password) async {
    try{
      final credential = await firebaseAuth.signInWithEmailAndPassword(email: email,password: password);
      if(credential.user != null){
        _user = credential.user;
        return true;
      }
    }catch(e){ 
      print(e);
    }
    return false;
  }

  void AuthStateChangeStreamListner(User? user){
    if(user != null){
      _user =  user;
    }else{
      _user = null;
    }
  }

  Future<bool> logout() async {
    try{
       await firebaseAuth.signOut();
       return true;
    }catch(e){
      print(e);
    }
    return false;
  }
} 