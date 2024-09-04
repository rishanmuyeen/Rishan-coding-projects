import 'package:chatapp/models/chat.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/models/user_profile_dart';
import 'package:chatapp/services/auth_service.dart';
 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart'; 

class Database {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference? _userCollection;
  CollectionReference? _chatCollection; 
  late AuthService _authService; 
  final  GetIt _getIt = GetIt.instance;


  Database(){ 
    _authService = _getIt.get<AuthService>();
    setUpCollectionReferences(); 
  }

  void setUpCollectionReferences(){
    _userCollection = _firebaseFirestore.collection('users')
      .withConverter<UserProfile>(
        fromFirestore: (snapshots,_) => UserProfile.fromJson(snapshots.data()!) ,
        toFirestore: (userprofile,_)=> userprofile.toJson(), 
      );
    _chatCollection  = _firebaseFirestore.collection('chats')
      .withConverter<Chat>(
        fromFirestore: (snapshots,_)=> Chat.fromJson(snapshots.data()!),
          toFirestore: ( chat,_) => chat.toJson()) ; 
  }
  Future<void> createUserProfile({required UserProfile user_profile}) async{
    await _userCollection?.doc(user_profile.uid).set(user_profile);
  } 
   Stream<QuerySnapshot<UserProfile>> getUserProfile(){
    return _userCollection?.where("uid", isNotEqualTo: _authService.user!.uid).snapshots() as Stream<QuerySnapshot<UserProfile>>;
  }
  Future<void> createNewChat(String uid1,String uid2) async {
    String chatId = generateChatId(uid1: uid1, uid2: uid2);  
    final docRef = _chatCollection!.doc(chatId);
    final chat = Chat(id:  chatId, participants: [uid1,uid2 ], messages:[]); 
    await docRef.set(chat);
  } 

  Future<bool> checkChatExists(String uid1,String uid2) async{
    String chatId = generateChatId(uid1: uid1, uid2: uid2);  
    final result = await _chatCollection?.doc(chatId).get(); 
    if(result != null){
       return result.exists;
    }
    return false;
  } 
  String generateChatId({required String uid1,required String uid2}){
    List uids = [uid1,uid2];
    uids.sort();
    String chatId = uids.fold("", (id,uid) => "$id$uid");
    return chatId;
  }
  Future<void> sendChatMessage(String uid1,String uid2,Message message) async{
    String chatId = generateChatId(uid1: uid1, uid2: uid2);  
    final docRef = _chatCollection!.doc(chatId);
    try {
      await docRef.update({
        "messages": FieldValue.arrayUnion([
          message.toJson(),
        ]),
      });
    } catch (e) {
      print("Failed to send chat message: $e");
    }
  }
  Stream getChatData(String uid1,String uid2){
    String chatId = generateChatId(uid1: uid1, uid2: uid2);
    return _chatCollection?.doc(chatId).snapshots() as Stream<DocumentSnapshot<Chat>>;
  }  
}  