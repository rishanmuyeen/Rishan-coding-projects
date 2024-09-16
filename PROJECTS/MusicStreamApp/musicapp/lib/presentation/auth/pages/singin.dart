import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musicapp/common/widgets/appbar/appbar.dart';
import 'package:musicapp/common/widgets/button/app_button.dart';
import 'package:musicapp/core/configs/assets/app_vector.dart';
import 'package:musicapp/data/models/auth/signin_user.dart';
import 'package:musicapp/domain/usecases/auth/signin.dart';
import 'package:musicapp/presentation/auth/pages/signup.dart';
import 'package:musicapp/presentation/home/pages/home.dart';
import 'package:musicapp/service_locator.dart';

// ignore: must_be_immutable
class SignIn extends StatelessWidget {
  SignIn({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SignInText(context),
      appBar: BasicAppBar(title: SvgPicture.asset(AppVector.logo,height: 40,width: 20,)),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            signInText(context),
            SizedBox(height: 20,),
            EmailField(),
            SizedBox(height: 20,),
            PasswordField(),
            SizedBox(height: 20,),
            BasicButton(
              onpressed:() async {
                var result = await sl<SigninUseCase>().call(
                  params: SigninUser(
                    email: email.text.toString(), 
                    password: password.text.toString()
                  )
                ); 
                result.fold(
                  (ifLeft){
                    var snackbar = SnackBar(content: Text(ifLeft));
                    ScaffoldMessenger.of(context).showSnackBar(snackbar); 
                  }, 
                  (ifRight){
                    Navigator.pushAndRemoveUntil(
                      context, 
                      MaterialPageRoute(builder:  (BuildContext context) => HomePage()), 
                      (route) => false,
                    );
                  }
                );
              } ,
              title: "Login"
            )
          ],
        ),
      ),
    );
  }
  Widget signInText(context){
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Text(
      "Sign In",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  } 
  Widget EmailField(){
    return TextField(
      controller: email,
      decoration: InputDecoration(
        hintText: "Email Address"
      ),
    );
  }
  Widget PasswordField(){
    return TextField(
      controller: password ,
      decoration: InputDecoration(
        hintText: "Password"
      ),
    );
  }
  Widget SignInText(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Dont have an account?",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=> SignUp()));
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          )
        )
      ],
    );
  }
}