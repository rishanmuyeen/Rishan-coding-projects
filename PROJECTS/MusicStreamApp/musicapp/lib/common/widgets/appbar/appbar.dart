import 'package:flutter/material.dart';
import 'package:musicapp/common/helper/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? action;
  final Color? backgroundcolor;
  final bool backbtn;
  const BasicAppBar({super.key,this.title,this.backbtn = false,this.action,this.backgroundcolor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:backgroundcolor?? Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: title ?? Text("") ,
      actions: [
        action ?? Container()
      ],
      leading:backbtn? null : IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color:context.isDarkMode? Colors.white.withOpacity(0.03): Colors.black.withOpacity(0.04),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back_ios_new_rounded, 
            size: 15 ,
            color: context.isDarkMode? Colors.white: Colors.black,
          ),
        )
      ),
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
} 