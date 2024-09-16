import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musicapp/common/widgets/button/app_button.dart';
import 'package:musicapp/core/configs/assets/app_images.dart';
import 'package:musicapp/core/configs/assets/app_vector.dart';
import 'package:musicapp/core/configs/theme/appColor.dart';
import 'package:musicapp/presentation/choose_mode/page/mode.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

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
                  AppImage.introBackground
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
                    'Enjoy Listening To Musice',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 21),
                  Text(
                    "Music lifts the spirit and touches the heart. Whether it's the rhythm or the lyrics, there's pure joy in immersing yourself in your favorite tunes. Let the melodies bring a smile to your face, wherever you are",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey ,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20,),
                  BasicButton(
                    onpressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder:  (BuildContext context) => ChooseModePage())
                      );
                    },
                    title: "Get Started"
                  )
                ],
              ),
          ),
        ],
       ),
    );
  }
} 