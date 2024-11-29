import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:realtime_db/controller/auth_service.dart';
import 'package:realtime_db/model/user_model.dart';

class UpdateUserScreen extends StatefulWidget {

  final String userId;
  final String name;
  final String age;
  final String gender;
  const UpdateUserScreen({super.key,required this.userId,required this.name,required this.age,required this.gender});

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  bool isUpdating = false;
  Controller controller = Get.put(Controller());

  void initState(){
  _nameController =TextEditingController(text: widget.name);
  _ageController =TextEditingController(text: widget.age);
  _genderController = TextEditingController(text: widget.gender);
  super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UpdateUserScreen',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_pin,
              color: Colors.blueAccent,
              size: 120,
            ),
            _textEditForm(_nameController, 'Enter name'),
            SizedBox(
              height: 10,
            ),
            _textEditForm(_ageController, 'Enter age'),
            SizedBox(
              height: 10,
            ),
            _textEditForm(_genderController, 'Enter gender'),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  shadowColor: Colors.blueGrey,
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.white, width: 2)),
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15)),
              onPressed: () {
                updateData();
              },
              child: Text('update'),
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
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(10))),
        ),
      ),
    );
  }

  void updateData() async{
   var name = _nameController.text;
    var age = _ageController.text;
    var gender = _genderController.text;
    if(name.isNotEmpty && age.isNotEmpty && gender.isNotEmpty){
      startProgress();
      String id = widget.userId;
      var data = UserModel(userId: id, name: name, age: age, gender: gender);
      await controller.updateUser(data);
      stopProgress();
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'User updated successfully');
    }
    else{
      Fluttertoast.showToast(msg: 'Please fill all the fields');
    }
  }
  void startProgress(){
    isUpdating = true;
  }
  void stopProgress(){
    isUpdating = false;
  }
}
