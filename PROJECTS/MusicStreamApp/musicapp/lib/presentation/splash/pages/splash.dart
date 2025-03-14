 import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musicapp/core/configs/assets/app_vector.dart';
import 'package:musicapp/presentation/Intro/pages/get_started.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirect();
  }
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          AppVector.logo 
         ),
      ),
    );
  }

  Future<void> redirect() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => GetStartedPage()
      )
    );
  }
} 