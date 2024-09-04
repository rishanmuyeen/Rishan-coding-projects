import 'package:chatapp/models/user_profile_dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/services/alert_service.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/database_service.dart';
import 'package:chatapp/services/navigation_service.dart';
import 'package:chatapp/widgets/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 
  final GetIt _getIt = GetIt.instance; 
  late AuthService _authService;
  late NavigationService _navigationService;
  late AlertService _alertService;
  late Database _database;

  @override
  void initState() {
    super.initState();
    _authService =  _getIt.get<AuthService>();
    _alertService = _getIt.get<AlertService>();
    _navigationService = _getIt.get<NavigationService>(); 
    _database = _getIt.get<Database>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text(
          "Messages",
          style: GoogleFonts.montserrat(
          color: Colors.white, // Text color
          fontSize: 20,        // Optional: adjust font size
          fontWeight: FontWeight.bold, // Optional: adjust font weight
          ),
        ),
        actions: [
          IconButton( 
            onPressed: ()async {
              bool result = await _authService.logout();
              if(result){
                _navigationService.pushReplacmentNamed("/login"); 
                _alertService.showToast(text: "Successfully logged out!",icon: Icons.logout);
              }
            },
            color: Colors.red, // Add functionality here for the logout button
            icon: Icon(Icons.logout), // Moved the closing parenthesis here
          ),
        ],
      ),backgroundColor: Colors.blueGrey[800],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: 
                  Text("",style:GoogleFonts.montserrat(
                    color: Colors.white, // Text color
                    fontSize: 20,        // Optional: adjust font size
                    fontWeight: FontWeight.bold,
                  )
                )
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.80, // Specify a height for the curved section
                  color: Colors.blueGrey[700],
                  child: buildUi(),
                ),
              ),
              Footer(), // Footer displayed after the ClipRRect section
            ],
          ),
        )
      );
  }
  Widget buildUi() {
  return SafeArea(
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Column(
        children: [
          Expanded(
            child: chatLists(), // Chat list takes up available space
          ),
        ],
      ),
    ),
  );
  }

  
  Widget chatLists(){
    return StreamBuilder(stream: _database.getUserProfile() , builder: (context,snapshot){
      if(snapshot.hasError){
        return Center(
          child: Text("Unable to the data! "),
        );
      }
      if(snapshot.hasData && snapshot.data != null){
        final users = snapshot.data!.docs; 
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            UserProfile user = users[index].data();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ChatTile(
                    userProfile: user,
                    onTap: () async {
                      final checkchatExists = await _database.checkChatExists(
                        _authService.user!.uid,
                        user.uid!,
                      );
                      if (!checkchatExists) {
                        await _database.createNewChat(
                          _authService.user!.uid,
                          user.uid!,
                        );
                      }
                      _navigationService.push(MaterialPageRoute(
                        builder: (context) {
                          return ChatPage(chatUser: user);
                        },
                      ));
                    },
                  ),
                ),
                Divider(
                  color: Theme.of(context).dividerColor, // Use the theme's divider color
                  thickness: 2.0,
                ),
              ],
            );
          },
        );
      }
      return Center(child: CircularProgressIndicator());
    }); 
  }

  Widget Footer(){ 
    return Container(
      width: MediaQuery.of(context).size.width,
      child: 
    Row(
      mainAxisAlignment:  MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("Created by Rishan Muyeen",
          style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.white,
          ),
        ),
      ],
    ));
  }
}