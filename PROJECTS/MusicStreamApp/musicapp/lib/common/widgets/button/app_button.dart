 import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  final VoidCallback onpressed;
  final String title;
  final double height;
  const BasicButton(
    {super.key, required this.onpressed, required this.title,this.height=80} 
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton( 
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height)
      ),
      child: Text(
        title
       ),
    );
  }
} 