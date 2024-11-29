import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:realtime_db/controller/auth_service.dart';
import 'package:realtime_db/view/crud_screen/add_user_screen.dart';
import 'package:realtime_db/view/crud_screen/update_user_screen.dart';
import 'package:realtime_db/view/intro_screen/login_screen.dart';

import '../../model/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = AuthService();
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  List<UserModel> datas = [];
  bool isLoading = false;
  Controller controller = Get.put(Controller());

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.purpleAccent, Colors.blueAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'RealTimeDataBase',
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.yellowAccent,
          actions: [
            IconButton(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        title: Text('logOut here'),
                        content: Text('are you sure'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('cancel'),
                            onPressed: () {
                              Navigator.of(dialogContext)
                                  .pop(); // Dismiss alert dialog
                            },
                          ),
                          TextButton(
                            child: Text('yes'),
                            onPressed: () {
                              logOutUser();
                              // Dismiss alert dialog
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.logout_outlined,
                  color: Colors.blueAccent,
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddUserScreen()));
          },
          label: Text(
            'AddUser',
            style: TextStyle(color: Colors.blueAccent, fontSize: 16),
          ),
          icon: Icon(
            Icons.add,
            color: Colors.blueAccent,
          ),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : datas.isNotEmpty
                    ? ListView.builder(
                        itemCount: datas.length,
                        itemBuilder: (context, index) {
                          final data = datas[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: InkWell(
                              onTap: () {
                                _deleteUserDialog(datas[index].userId);
                              },
                              onLongPress: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateUserScreen(
                                              name: datas[index].name,
                                              userId: datas[index].userId,
                                              age: datas[index].age,
                                              gender: datas[index].gender,
                                            )));
                              },
                              child: Card(
                                elevation: 7,
                                color: Colors.white,
                                shadowColor: Colors.grey.shade400,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    maxRadius: 25,
                                    child: Text('${index + 1}'),
                                  ),
                                  title: Text(
                                    data.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    data.gender,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Text(
                                    data.age,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                    : Text('no data found')),
      ),
    );
  }

  Future<void> getdata() async {
    databaseReference.child('EmployeeInfo').onValue.listen((event) {
      final dataSnapShot = event.snapshot.value as Map<dynamic, dynamic>?;
      final List<UserModel> tempDataList = [];
      if (dataSnapShot != null) {
        dataSnapShot.forEach((key, value) {
          final userList = UserModel.fromjson(Map<String, dynamic>.from(value));
          tempDataList.add(userList);
        });
      }
      setState(() {
        // stopProgress();
        datas = tempDataList;
      });
    });
  }

  // void startProgress() {
  //   setState(() {
  //     isLoading = true;
  //   });
  // }

  // void stopProgress() {
  //   setState(() {
  //     getdata();
  //     isLoading = false;
  //   });
  // }

  void logOutUser() async {
    try {
      auth.logOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LogInScreen()));
      Fluttertoast.showToast(msg: 'logOut successful!');
    } catch (e) {
      log('logOut failed');
    }
  }

  void _deleteUserDialog(String userId) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Delete User'),
          content: Text('Are you sure to delete!'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                controller.deleteData(userId);
                getdata();
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }
}
