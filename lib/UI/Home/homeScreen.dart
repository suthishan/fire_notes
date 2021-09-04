import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_task/UI/addNotes/addscreen.dart';
import 'package:flutter_firebase_task/UI/addNotes/edit_screen.dart';
import 'package:flutter_firebase_task/UI/auth/authScreen.dart';
import 'package:flutter_firebase_task/UI/widgets/item_list.dart';
import 'package:flutter_firebase_task/constants/AppConstants.dart';
import 'package:flutter_firebase_task/main.dart';
import 'package:flutter_firebase_task/model/user.dart';
import 'package:flutter_firebase_task/services/database.dart';

import 'package:flutter_firebase_task/services/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late User user;
  String uUidPrefs = '';

  @override
  void initState() {
    super.initState();
    user = widget.user;
    getUserId();
    setState(() {
      debugPrint('uUidPrefs: ' + uUidPrefs);
    });
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uUidPrefs = prefs.getString('userUid') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: Color(COLOR_PRIMARY),
              ),
            ),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ),
              leading: Transform.rotate(
                  angle: pi / 1,
                  child: Icon(Icons.exit_to_app, color: Colors.black)),
              onTap: () async {
                await auth.FirebaseAuth.instance.signOut();
                MyAppState.currentUser = null;
                pushAndRemoveUntil(context, AuthScreen(), false);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white.withOpacity(0.2),
        centerTitle: true,
        actions: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircleAvatar(
                    child: Image.asset(
                      'assets/profile.png',
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            onTap: () {
// showGeneralDialog(context: context, pageBuilder: pageBuilder)
              showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: MaterialLocalizations.of(context)
                      .modalBarrierDismissLabel,
                  barrierColor: Colors.black45,
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (BuildContext buildContext, Animation animation,
                      Animation secondaryAnimation) {
                    return Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 90,
                          height: MediaQuery.of(context).size.height - 225,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/profile.png',
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              SizedBox(
                                height: 25,
                              ),
                              Text(
                                user.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontFamily: "Roboto",
                                    fontSize: 36,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                user.email,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontFamily: "Roboto",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddScreen(

// user.userID

                  ),
            ),
          );
        },
        backgroundColor: Color(COLOR_PRIMARY),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Container(
            //   padding: EdgeInsets.only(left: 32, right: 32, top: 32),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       SizedBox(
            //           height: 100,
            //           width: 100,
            //           child: ClipOval(
            //             child: Image.asset(
            //               'assets/profile.png',
            //               fit: BoxFit.cover,
            //             ),
            //           )),
            //       SizedBox(
            //         width: 16,
            //       ),
            //       Expanded(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: <Widget>[
            //             Text(
            //               user.name,
            //               style: TextStyle(
            //                   color: Colors.grey[800],
            //                   fontFamily: "Roboto",
            //                   fontSize: 36,
            //                   fontWeight: FontWeight.w700),
            //             ),
            //             Text(
            //               user.email,
            //               style: TextStyle(
            //                   color: Colors.grey[500],
            //                   fontFamily: "Roboto",
            //                   fontSize: 16,
            //                   fontWeight: FontWeight.w400),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 40),
            //   child: ConstrainedBox(
            //     constraints: const BoxConstraints(minWidth: double.infinity),
            //     child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         primary: Color(COLOR_PRIMARY),
            //         textStyle: TextStyle(color: Colors.white),
            //         padding: EdgeInsets.only(top: 12, bottom: 12),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(25.0),
            //           side: BorderSide(
            //             color: Color(COLOR_PRIMARY),
            //           ),
            //         ),
            //       ),
            //       child: Text(
            //         'Add User',
            //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //       ),
            //       onPressed: () => push(
            //         context,
            //         new AddUser(),
            //       ),
            //     ),
            //   ),
            // ),
            _itemList(),
          ],
        ),
      ),
    );
  }

  Widget _itemList() {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.readItems(uUidPrefs),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => SizedBox(height: 1.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var noteInfo = snapshot.data!.docs[index].data()! as Map;
              String docID = snapshot.data!.docs[index].id;
              String title = noteInfo['title'];
              String description = noteInfo['description'];

              return Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 1.5, color: Colors.grey.withOpacity(0.5))
                    ],
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.white, width: 1.0),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onTap: () {
                      debugPrint('list item- on tap: ' + uUidPrefs);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditScreen(
                            currentTitle: title,
                            currentDescription: description,
                            documentId: docID,
                          ),
                        ),
                      );

                      debugPrint(docID);
                    },
                    title: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              );
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Color(0xFFF57C00),
            ),
          ),
        );
      },
    );
  }
}
