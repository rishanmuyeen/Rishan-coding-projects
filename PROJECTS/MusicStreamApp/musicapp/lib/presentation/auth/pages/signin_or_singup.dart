import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musicapp/common/helper/is_dark_mode.dart';
import 'package:musicapp/common/widgets/appbar/appbar.dart';
import 'package:musicapp/common/widgets/button/app_button.dart';
import 'package:musicapp/core/configs/assets/app_images.dart';
import 'package:musicapp/core/configs/assets/app_vector.dart';
import 'package:musicapp/core/configs/theme/appColor.dart';
import 'package:musicapp/presentation/auth/pages/signup.dart';
import 'package:musicapp/presentation/auth/pages/singin.dart';

class SigninOrSingup extends StatelessWidget {
  const SigninOrSingup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Stack(
        children: [
          BasicAppBar(),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              AppVector.top_pattern
            ),
          ),
          
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(
              AppVector.bottom_pattern 
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              AppImage.signin_or_signout
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal:  40
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppVector.logo),
                  SizedBox(height: 55,),
                  Text(
                    "Enjoy listening to music",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: context.isDarkMode? Colors.white: Colors.black,
                    ),
                  ),
                  Text(
                    "Spotiy is prorietary Swedish udio streaming and media services provider",
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center ,
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Expanded(
                        flex: 1 ,
                        child: BasicButton(
                          onpressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SignUp()));
                          },
                          title: "Register"
                        ) 
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        flex: 1 ,
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SignIn()));
                          } ,
                          child: Text(
                            "Sign-In",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: context.isDarkMode? Colors.white:Colors.black,
                              fontSize: 16
                            ),
                          ),
                        ) 
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
       ),
    );
  }
}