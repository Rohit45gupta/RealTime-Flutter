import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:random_string/random_string.dart';
import 'package:realtime_db/model/user_model.dart';

import '../../controller/auth_service.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AddUserScreen',
          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_pin, color: Colors.blueAccent, size: 120,),
            _textEditForm(_nameController, 'Enter name'),
            const SizedBox(height: 10,),
            _textEditForm(_ageController, 'Enter age'),
            const SizedBox(height: 10,),
            _textEditForm(_genderController, 'Enter gender'),
            const SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  shadowColor: Colors.blueGrey,
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.white, width: 2)),
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15)),
              onPressed: () {
                addUser();
              },
              child: Text('save'),
            )
          ],
        ),
      ),
    );
  }

  Widget _textEditForm(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Card(
        elevation: 7,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(10))),
        ),
      ),
    );
  }

  void addUser() async{
    final name = _nameController.text;
    final age = _ageController.text;
    final gender  = _genderController.text;
    final userId = randomAlphaNumeric(10);
    if(name.isNotEmpty && age.isNotEmpty && gender.isNotEmpty){
      try{
        var data = UserModel(userId: userId, name: name, age: age, gender: gender);
        controller.addData(data);
        Fluttertoast.showToast(msg: 'Add Data Successfully');
        Navigator.pop(context);
      }catch(e){
       log('Something went wrong $e');
       Fluttertoast.showToast(msg: ' Something went wrong $e');
      }
    }else{
      Fluttertoast.showToast(msg: 'Fill all the fields');
    }
  }
}
