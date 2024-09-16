import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musicapp/common/helper/is_dark_mode.dart';
import 'package:musicapp/common/widgets/appbar/appbar.dart';
import 'package:musicapp/core/configs/assets/app_images.dart';
import 'package:musicapp/core/configs/assets/app_vector.dart';
import 'package:musicapp/core/configs/theme/appColor.dart';
import 'package:musicapp/presentation/home/widgets/new-songs.dart';
import 'package:musicapp/presentation/home/widgets/playlist.dart';
import 'package:musicapp/presentation/profile/pages/profile.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: BasicAppBar(
        action: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> ProfilePage()));
          }, 
          icon: Icon(Icons.person,size: 40,)
        ),
        backbtn: true,
        title: SvgPicture.asset(
          AppVector.logo,
          height: 40,
          width: 20,
        )
      ),
      body: SingleChildScrollView(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: [
            HomeTopCard(),
            Tabs(),
            SizedBox(height: 15,),
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: tabController,
                children: [
                   const NewsSongs(),
                   Container(child: Center(child: Text("Subscribe to watch videos")),),
                   Container(child: Center(child: Text("Subscribe to view the artist names")),),
                   Container(child: Center(child: Text("Subscribe to listen podcasts")),),
                ]
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10, 
              ),
              child: Playlist(),
            ),
          ],
        ),
      ),
    );
  }

  Widget HomeTopCard(){
    return Center(
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                AppVector.home_top_card
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(
                  right: 60,
                ),
                child: Image.asset(
                  AppImage.home_artist
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Tabs(){
    return TabBar(
      controller: tabController,
      indicatorColor: AppColors.primary,
      isScrollable: true,
      labelColor: context.isDarkMode? Colors.white : Colors.black,
      padding: EdgeInsets.only(
        top: 30
      ),
      tabs: [
        Text("News",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),), 
        Text("Videos",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),
        Text("Artists",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),
        Text("Podcast",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),
      ],
    );
  }
} 