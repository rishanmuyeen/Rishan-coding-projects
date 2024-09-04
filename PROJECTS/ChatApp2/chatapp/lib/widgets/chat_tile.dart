import 'package:chatapp/models/user_profile_dart';
import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final UserProfile userProfile;
  final Function onTap;

  const ChatTile({super.key,required this.userProfile,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){ onTap(); },
      dense: false,
      leading: 
        CircleAvatar(backgroundImage: NetworkImage(userProfile.pfpURL!),
        radius: 30,
      ),title: Text(userProfile.name!),
      textColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}