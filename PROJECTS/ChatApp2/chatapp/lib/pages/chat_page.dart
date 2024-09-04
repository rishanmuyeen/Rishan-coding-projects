import 'dart:io';

import 'package:chatapp/models/chat.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/models/user_profile_dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/database_service.dart';
import 'package:chatapp/services/media_service.dart';
import 'package:chatapp/services/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ChatPage extends StatefulWidget {
  final UserProfile chatUser;
  const ChatPage({super.key,required this.chatUser}); 

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  late  AuthService _authService;
  late GetIt _getIt = GetIt.instance;
  late Database _database;
  late MediaService _mediaService;
  late StorageService _storageService;

  ChatUser? currentUser, otherUser;
  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    currentUser = ChatUser(id:_authService.user!.uid,firstName: _authService.user!.displayName);
    otherUser = ChatUser(id: widget.chatUser.uid! ,firstName: widget.chatUser.name,profileImage: widget.chatUser.pfpURL );
    _database = _getIt.get<Database >();
    _mediaService = _getIt<MediaService >(); 
    _storageService = _getIt.get<StorageService>();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text(widget.chatUser.name!,style: TextStyle(color: Colors.white),),
      ),
      body:Scaffold(backgroundColor: Colors.blueGrey[800],body: buildUi()) ,
    );
  }

  Widget buildUi(){
    return StreamBuilder(stream: _database.getChatData(currentUser!.id, otherUser!.id), builder: (context,snapshot){  
      Chat? chat = snapshot.data?.data(); 
      List<ChatMessage> messages= []; 
      if(chat != null && chat.messages != null){
        messages = GenerateChatMessagesList(chat .messages!);
      }    
      return DashChat(
        messageOptions: MessageOptions(
          showOtherUsersAvatar: true,
          showTime: true,
        ),
        inputOptions: InputOptions(
          alwaysShowSend: true,
          trailing:  [
            mediaMessageButton(),
          ],
        ),
        currentUser: currentUser! ,
          onSend: sendMessage,
          messages: messages,
      );
    });
  }
  Future<void> sendMessage(ChatMessage chatmessage) async {
    if(chatmessage.medias?.isNotEmpty ?? false){
      if(chatmessage.medias!.first.type == MediaType.image){
        Message message = Message(
          senderID:chatmessage.user.id,
          content: chatmessage.medias!.first.url ,
          messageType: MessageType.Image, 
          sentAt: Timestamp.fromDate(chatmessage.createdAt)
        );
        await  _database.sendChatMessage(currentUser!.id, otherUser!.id, message); 
     }
    }else{
      Message message = Message(
      senderID: currentUser!.id ,
      content: chatmessage.text ,
      messageType: MessageType.Text,
      sentAt:Timestamp.fromDate(chatmessage.createdAt),
      );
      await _database.sendChatMessage(currentUser!.id, otherUser!.id, message);  
    }
    
  }

  List<ChatMessage>  GenerateChatMessagesList(List<Message> message){
    List<ChatMessage> chatmessage = message.map((m){
      if(m.messageType == MessageType.Image ){
        return  ChatMessage(
          user: m.senderID == currentUser!.id ? currentUser! : otherUser!,
          createdAt: m.sentAt!.toDate(),
          medias: [
            ChatMedia(url: m.content!, fileName:"", type: MediaType.image)
          ]
        ); 
      }else{ 
        return ChatMessage(
        user: m.senderID == currentUser!.id ? currentUser! : otherUser!,
        text: m.content!,
        createdAt: m.sentAt!.toDate()
        ); 
      }
    }).toList( );
    chatmessage.sort((a,b) {
      return b.createdAt.compareTo(a.createdAt);
    });
    return chatmessage;
   }

   Widget mediaMessageButton(){
    return IconButton(onPressed: () async{
      File? file = await _mediaService.getImageFromGallery(); 
      if(file != null){
        String chatId = generateChatId(uid1: currentUser!.id, uid2: otherUser!.id);
        String? dowunloadUrl = await _storageService.uploadingImagesToChat(file: file, chatId : chatId);
        if(dowunloadUrl != null){
           ChatMessage chatMessage =  ChatMessage(
            user: currentUser!,
            createdAt:DateTime.now(),
            medias: [
              ChatMedia(
                url: dowunloadUrl,
                fileName:"",
                type: MediaType.image
              )
            ]
          );
          sendMessage(chatMessage);
        }
      }
    },
     icon: Icon(
      Icons.image,
      color: Colors.blue[200],
      )
    );
   }
   String generateChatId({required String uid1,required String uid2}){
    List uids = [uid1,uid2];
    uids.sort();
    String chatId = uids.fold("", (id,uid) => "$id$uid");
    return chatId;
  }
} 
 
