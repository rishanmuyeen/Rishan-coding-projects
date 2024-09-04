import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final String labelname;
  final RegExp regExp; 
  final bool obscureText;
  final void Function(String?) onSaved;
  const CustomForm({super.key,required this.labelname,required this.regExp,this.obscureText=false,required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      obscureText: obscureText ,
      validator: (value) {
        if(value !=  null && regExp.hasMatch( value)){
          return null;
        }else{
          return "Enter the valid ${labelname}";
        }
      },
      decoration: InputDecoration(
        label: Text(labelname),
        border: OutlineInputBorder()
      ),
    );
  } 
}