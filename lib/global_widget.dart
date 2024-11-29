import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalWidget{



 static Widget textEditForm(
      TextEditingController controller, String hintText, IconData Data,
      {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Card(
        elevation: 7,
        child: TextFormField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(Data),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(10))),
        ),
      ),
    );
  }
}