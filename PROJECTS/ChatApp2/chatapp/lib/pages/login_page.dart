import 'package:chatapp/const.dart';
import 'package:chatapp/services/alert_service.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/navigation_service.dart';
import 'package:chatapp/widgets/custom_form.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GetIt _getIt = GetIt.instance;
  late AuthService authService;
  late NavigationService _navigationService;
  late AlertService _alertService;
  final GlobalKey<FormState> globalKey = GlobalKey(); 

  String? email,password;
  @override
  void initState() {
    super.initState();
    authService =  _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>(); 
    _alertService = _getIt.get<AlertService>();
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BuildUi(),
    );
  } 
  Widget BuildUi(){
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
          ),
          child: Column(
            children: [HeaderText(),LoginForm(),CreateAccount()],
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
          Text("Welcome Back!",
           style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            )
          ),
          Text("Hello again you have been missed!",
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

  Widget LoginForm(){
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.4,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.05,
      ),
      child: Form(
        key: globalKey,
        child: Column(
          children: [
            CustomForm(labelname: "Email",regExp: EMAIL_VALIDATION_REGEX, onSaved: (value) {
              setState(() {
                email = value;
              });
            },), 
            SizedBox(height: 30,),
            CustomForm(labelname: "Password",regExp: PASSWORD_VALIDATION_REGEX,obscureText: true, onSaved: (value) {
              setState(() {
                password = value;
              });
            },),
            SizedBox(height: 100,),
            LoginButton(),
          ], 
        ) 
      )
    );
  } 
  Widget LoginButton(){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        onPressed: () async {
          if(globalKey.currentState?.validate() ?? false){
            globalKey.currentState?.save();
            print(email);
            print(password);
            bool result = await authService.login(email!, password!);
            print(result);          
            if(result){
              print("Successfully logged in");
              _navigationService.pushReplacmentNamed("/home");
              _alertService.showToast(text: "Successfully logged in",icon: Icons.login);

            }
          }else{
            _alertService.showToast(text: "Failed to login, Please try again",icon: Icons.error);
          }
        },
        color: Theme.of(context).colorScheme.primary,
        child: Text("Login",
        style: TextStyle(
          color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget CreateAccount(){ 
    return Expanded(child: 
    Row(
      mainAxisAlignment:  MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("Don't have an account?",
          style: TextStyle(
          fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: 10,), 
        GestureDetector(
          onTap: (){
            _navigationService.pushNamed("/register"); 
          },
          child: Text("Sign Up", 
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),), 
        )
      ],
    ));
  }
}   