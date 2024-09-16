import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musicapp/common/widgets/button/app_button.dart';
import 'package:musicapp/core/configs/assets/app_images.dart';
import 'package:musicapp/core/configs/assets/app_vector.dart';
import 'package:musicapp/core/configs/theme/appColor.dart';
import 'package:musicapp/presentation/auth/pages/signin_or_singup.dart';
import 'package:musicapp/presentation/choose_mode/bloc/theme_cubit.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  AppImage.choose_mode_Background
                )
              )
            ),
          ),
          Container(
             color: Colors.black.withOpacity(0.15),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40,
            ),
            child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(
                      AppVector.logo
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Choose a mode',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          GestureDetector (
                            onTap: (){
                              context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                            },
                            child: ClipOval(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                                child: Container(
                                  height: 80, 
                                  width: 80 ,
                                  decoration: BoxDecoration(
                                    color: Color(0xff30393C).withOpacity(0.5),
                                    shape: BoxShape.circle
                                  ),
                                  child: SvgPicture.asset(
                                    AppVector.moon,
                                    fit: BoxFit.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Dark mode",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: AppColors.grey
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: 40,),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                            },
                            child: ClipOval(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                                child: Container(
                                  height: 80, 
                                  width: 80 ,
                                  decoration: BoxDecoration(
                                    color: Color(0xff30393C).withOpacity(0.5),
                                    shape: BoxShape.circle
                                  ),
                                  child: SvgPicture.asset(
                                    AppVector.sun,
                                    fit: BoxFit.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Light mode",
                            style: TextStyle( 
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: AppColors.grey
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
                  BasicButton(
                    onpressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder:  (BuildContext context) => SigninOrSingup())
                      );
                    },
                    title: "Continue"
                  )
                ],
              ),
          ),
        ],
       ),
    );
  }
}