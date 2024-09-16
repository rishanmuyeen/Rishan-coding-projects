import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musicapp/common/widgets/appbar/appbar.dart';
import 'package:musicapp/common/widgets/button/app_button.dart';
import 'package:musicapp/core/configs/assets/app_vector.dart';
import 'package:musicapp/data/models/auth/create_user.dart';
import 'package:musicapp/domain/usecases/auth/signup.dart';
import 'package:musicapp/presentation/auth/pages/singin.dart';
import 'package:musicapp/presentation/home/pages/home.dart';
import 'package:musicapp/service_locator.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final TextEditingController fullname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SignUpText(context),
      appBar: BasicAppBar(title: SvgPicture.asset(AppVector.logo,height: 40,width: 20,)),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RegisterText(context),
            SizedBox(height: 20,),
            FullNameField(),
            SizedBox(height: 20,),
            EmailField(),
            SizedBox(height: 20,),
            PasswordField(),
            SizedBox(height: 20,),
            BasicButton(
              onpressed:()async{
                var result = await sl<SignupUseCase>().call(
                  params: CreateUser(
                    email: email.text.toString(), 
                    fullname: fullname.text.toString(), 
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
              title: "Create Account"
            )
          ],
        ),
      ),
    );
  }
  Widget RegisterText(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Text(
      "Register",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget FullNameField(){
    return TextField(
      controller: fullname,
      decoration: InputDecoration(
        hintText: "Full Name"
      ),
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
      controller: password,
      decoration: InputDecoration(
        hintText: "Password"
      ),
    );
  }
  Widget SignUpText(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=> SignIn()));
          },
          child: Text(
            "Sign In",
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