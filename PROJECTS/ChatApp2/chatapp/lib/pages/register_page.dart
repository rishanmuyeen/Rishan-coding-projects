import 'package:chatapp/const.dart';
import 'package:chatapp/models/user_profile_dart';
import 'package:chatapp/services/alert_service.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/database_service.dart';
import 'package:chatapp/services/media_service.dart';
import 'package:chatapp/services/navigation_service.dart';
import 'package:chatapp/services/storage_service.dart';
import 'package:chatapp/widgets/custom_form.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get_it/get_it.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GetIt _getIt = GetIt.instance; 

  final GlobalKey<FormState> registerationKey = GlobalKey(); 

  late MediaService _mediaService; 

  late NavigationService _navigationService;

  late AuthService _authService;

  late StorageService _storageService;

  late Database _database;

  late AlertService _alertService;
  
  File? selectedImage;

  String? email,password,name;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _mediaService = _getIt.get<MediaService>();
    _navigationService = _getIt.get<NavigationService>();
    _authService = _getIt.get<AuthService>();
    _storageService = _getIt.get<StorageService >();
    _database = _getIt.get<Database >();
    _alertService = _getIt.get<AlertService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: buildUi(),
    );
  }
  Widget buildUi(){
    return SafeArea(
      child:
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        child: Column(
          children: [
            HeaderText(),
            if(!isLoading) registerForm(),
            if(!isLoading) LoginToAccount(),
            if(isLoading) Expanded(child: Center(child: CircularProgressIndicator()))
          ],
        ),
      )
    );
  }
  Widget HeaderText(){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Welcome, Let's get going!",
           style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            )
          ),
          Text("Fill out the form to register!",
           style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
            ) 
          )
        ],
      ),
    );
  }
  Widget registerForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.1,
          vertical: MediaQuery.sizeOf(context).height * 0.05,
        ),
        child: Form(
          key: registerationKey,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              profilePic(),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              CustomForm(labelname: "Name ", regExp: NAME_VALIDATION_REGEX, onSaved: (value) {setState(() {
                name = value;
              });}),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              CustomForm(labelname: "Email", regExp: EMAIL_VALIDATION_REGEX, onSaved: (value) {setState(() {
                email = value;
              });}),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              CustomForm(labelname: "Password", regExp: PASSWORD_VALIDATION_REGEX, onSaved: (value) {setState(() {
                password = value;
              });}),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
              RegisterButton(),
            ],
          ),
        ),
      ),
    );
  }
  Widget profilePic(){
    return GestureDetector(
      onTap:() async{
        File? file = await _mediaService.getImageFromGallery();
        if(file != null){
          setState(() {
            selectedImage = file;  
          });
        }
      } ,
       child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.15,
         backgroundImage: selectedImage != null ? FileImage(selectedImage!) : NetworkImage(PLACEHOLDER_PFP) as ImageProvider ,
       ),
     ); 
  }
  Widget LoginToAccount(){ 
    return Expanded(child: 
    Row(
      mainAxisAlignment:  MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("Already have an account?",
          style: TextStyle(
          fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: 10,), 
        GestureDetector(
          onTap: (){
            _navigationService.goBack(); 
          },
          child: Text("Login", 
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),), 
        )
      ],
    ));
  }
  Widget RegisterButton() {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: MaterialButton(
      color: Theme.of(context).colorScheme.primary,
      onPressed: () async {
        setState(() {
          isLoading =true;
        });
        try{
          if ((registerationKey.currentState?.validate() ?? false) && selectedImage != null)
          {
            registerationKey.currentState?.save();
            bool result = await _authService.signUp(email!, password!);
            if(result){
              String? pfpUrl = await _storageService.uploadUserPic( file: selectedImage!,uid: _authService.user!.uid,);
              if(pfpUrl != null){
                await _database.createUserProfile(
                   user_profile: UserProfile(uid: _authService.user!.uid,name: name,pfpURL: pfpUrl)
                );
                _alertService.showToast(text: "Successfully registered in!",icon: Icons.done);
                _navigationService.goBack();
                _navigationService.pushReplacmentNamed("/home");
                print("$result succesfully signed in");
              }else{
                _alertService.showToast(text: " Unable upload picture!",icon: Icons.cancel);
              } 
            }
          }else{
            _alertService.showToast(text: " Unable to register!",icon: Icons.cancel);
          } 
        }catch(e){
          print(e);
        }
        setState(() {
          isLoading = false;
        });
      },
      child: Text(
        "Register",
        style: TextStyle(color: Colors.white),
      ),
      )
    );
  }
}