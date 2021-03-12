import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shamba_app/common/constants.dart';
import 'package:shamba_app/models/User.dart';
import 'package:shamba_app/ui/UserAttendance.dart';
import 'package:shamba_app/utils/DatabaseHelper.dart';

import 'package:sqflite/sqflite.dart';



class ShambaUsersScreen extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return ShambaUsersScreenState();
  }
}

class ShambaUsersScreenState extends State<ShambaUsersScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  List<User> userList;
  int count = 0;
  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();
  ScrollController scrollController = ScrollController();
  TextEditingController etFNameController = TextEditingController();
  TextEditingController etLNameController = TextEditingController();
  TextEditingController etPhoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (userList == null) {
      userList = List<User>.empty(growable: true);
      updateList();
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
          // leading: Icon(Icons.toc),
          backgroundColor: Colors.orange,
          title: Text("Shamba Records"),),
      body:Column(
        children: <Widget>[
          Expanded(
            child: userList != null
                ? new UserView(
                userList: userList)
                : userList == null
                ? new Center(child: new CircularProgressIndicator())
                : new Center(
              child: new Text("No Users Pleas ADD!"),
            ),
          )
        ],
      ),
      floatingActionButton:

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton.extended(
                    heroTag: "btn1",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserAttendanceScreen()));
                    },
                    label: Text('Attendance',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.white, fontSize: 16))),
                    icon: Icon(
                      Icons.supervised_user_circle,
                      color: Colors.orange,
                    ),
                    backgroundColor: AppColors.PrimaryDarkColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton.extended(
                    heroTag: "btn2",
                    onPressed: () {

                      showAlert(context);
                    },
                    label: Text('Add User',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.white, fontSize: 16))),
                    icon: Icon(
                      Icons.supervised_user_circle,
                      color: Colors.orange,
                    ),
                    backgroundColor: AppColors.PrimaryDarkColor,
                  ),
                ),
              ),

            ],
          )


    );
  }





   void updateList() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<User>> noteListFuture =
          databaseHelper.getUserList();
      noteListFuture.then((noteList) {
        setState(() {
          this.userList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }







  void showAlert(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Shamba",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return StatefulBuilder(builder: (BuildContext context,
            StateSetter hasNoAccountState) {
          final node = FocusScope.of(context);
          return Padding(
              padding: const EdgeInsets.only(
                left: 10,
                top: 30,
                right: 10,
                bottom: 50,
              ),
              child: Container(
                height: 200,
                alignment: Alignment.topCenter,
                child: new Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),




                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onEditingComplete: () =>
                                node.nextFocus(),
                            keyboardType: TextInputType.name,
                            controller: etFNameController,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: AppColors
                                        .PrimaryDarkColor,
                                    fontSize: 14)),
                            decoration: new InputDecoration(
                              contentPadding:
                              const EdgeInsets.all(15.0),
                              focusedBorder:
                              OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                    AppColors
                                        .colorAccent,
                                    width: 2.0),
                              ),
                              enabledBorder:
                              OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:AppColors
                                        .PrimaryDarkColor,
                                    width: 2.0),
                              ),
                              labelText: 'Enter First Name',
                              labelStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: AppColors
                                          .PrimaryDarkColor,
                                      fontSize: 14)),
                            ),
                            autofocus: false,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onEditingComplete: () =>
                                node.nextFocus(),
                            keyboardType: TextInputType.name,
                            controller: etLNameController,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: AppColors
                                        .PrimaryDarkColor,
                                    fontSize: 14)),
                            decoration: new InputDecoration(
                              contentPadding:
                              const EdgeInsets.all(15.0),
                              focusedBorder:
                              OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                    AppColors
                                        .colorAccent,
                                    width: 2.0),
                              ),
                              enabledBorder:
                              OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors
                                        .colorAccent,
                                    width: 2.0),
                              ),
                              labelText: 'Enter Last Name',
                              labelStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: AppColors
                                          .colorAccent,
                                      fontSize: 14)),
                            ),
                            autofocus: false,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),



                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onEditingComplete: () =>
                                node.nextFocus(),
                            keyboardType: TextInputType.phone,
                            controller: etPhoneController,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: AppColors
                                        .PrimaryDarkColor,
                                    fontSize: 14)),
                            decoration: new InputDecoration(
                              contentPadding:
                              const EdgeInsets.all(15.0),
                              focusedBorder:
                              OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                    AppColors.colorAccent,
                                    width: 2.0),
                              ),
                              enabledBorder:
                              OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors
                                        .PrimaryDarkColor,
                                    width: 2.0),
                              ),
                              labelText:
                              'Enter Phone Number',
                              labelStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: AppColors
                                          .PrimaryDarkColor,
                                      fontSize: 14)),
                            ),
                            autofocus: false,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        Container(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(
                              width: 200,
                              // specific value
                              child: SizedBox(
                                width: double.infinity,
                                height: 35,
                                child: RaisedButton(
                                    child: Text(
                                        'REGISTER USER',
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: AppColors
                                                    .PrimaryDarkColor,
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                                fontSize:
                                                15))),
                                    color:
                                    AppColors.colorAccent,
                                    onPressed: () async {
                                      if (etFNameController
                                          .text.isEmpty &&
                                          etLNameController
                                              .text.isEmpty) {
                                        Fluttertoast
                                            .showToast(
                                            msg:
                                            'enter user names',
                                            toastLength: Toast
                                                .LENGTH_SHORT,
                                            gravity:
                                            ToastGravity
                                                .CENTER,
                                            timeInSecForIosWeb:
                                            1,
                                            backgroundColor:
                                            AppColors.red,
                                            textColor:
                                            AppColors
                                                .whitish,
                                            fontSize: 14.0);
                                      } else
                                      if (etPhoneController
                                          .text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg:
                                            'enter correct phone number',
                                            toastLength: Toast
                                                .LENGTH_SHORT,
                                            gravity:
                                            ToastGravity
                                                .CENTER,
                                            timeInSecForIosWeb:
                                            1,
                                            backgroundColor:
                                            AppColors.red,
                                            textColor:
                                            AppColors
                                                .whitish,
                                            fontSize: 14.0);
                                      }

                                      else {
                                        //add user to sqlite //can change to  post to server later on

                                        Navigator.pop(context);
                                        saveUser(
                                            context,
                                            User(
                                                DateTime.now().millisecondsSinceEpoch.toString(),
                                                etFNameController
                                                    .text,
                                                etLNameController
                                                    .text,
                                                etPhoneController
                                                    .text,0,""));
                                      updateList();
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius
                                                .circular(
                                                24)))),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        });
      },
      transitionBuilder: (context, anim1, anim2, childd) {
        return SlideTransition(
          position: Tween(
              begin: Offset(0, -1), end: Offset(0, 0))
              .animate(anim1),
          child: childd,
        );
      },
    );
  }





}
class UserView extends StatelessWidget {
 List<User> userList;

  UserView( {Key key, this.userList}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return StatefulBuilder(builder: (BuildContext context, initialState) {
      return ListView.builder(
          itemCount: userList == null ? 0 : userList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: AppColors.white,
                elevation: 10,
                child: Container(
                  // height: MediaQuery.of(context).size.height / 3.5,
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                      splashColor: AppColors.PrimaryColor,
                      onTap: () {

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Wrap(
                          // gap between lines
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(
                                  height: 4,
                                ),
                                InkWell(
                                    onTap: () {
                                      deleteWidget(
                                          context, index, initialState);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(3.0),
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: AppColors.colorAccent),
                                      ),
                                      child: new Row(children: [
                                        Icon(
                                          Icons.delete_forever,
                                          color: AppColors.red,
                                          size: 18,
                                        ),
                                      ]),
                                    )),
                                SizedBox(
                                  height: 4,
                                ),
                                InkWell(
                                    onTap: () {
                                      Fluttertoast
                                          .showToast(
                                          msg:
                                          'will be used to display individual attendance',
                                          toastLength: Toast
                                              .LENGTH_SHORT,
                                          gravity:
                                          ToastGravity
                                              .CENTER,
                                          timeInSecForIosWeb:
                                          1,
                                          backgroundColor:
                                          AppColors.red,
                                          textColor:
                                          AppColors
                                              .whitish,
                                          fontSize: 14.0);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(3.0),
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: AppColors.colorAccent),
                                      ),
                                      child: new Row(children: [
                                        Icon(
                                          Icons.remove_red_eye,
                                          color: AppColors.green,
                                          size: 18,
                                        ),
                                        Text("Attendance")
                                      ]),
                                    )),
                              ],
                            ),
                            Row(children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.person,
                                            color: AppColors.colorAccent,
                                            size: 18,
                                          ),
                                          Text("User : ",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: AppColors
                                                          .PrimaryDarkColor,
                                                      fontSize: 14))),
                                          Text(
                                              "${userList[index].firstName ?? ""}",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: AppColors
                                                          .PrimaryDarkColor,
                                                      fontSize: 14))),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.radio_button_checked_outlined,
                                            color: AppColors.colorAccent,
                                            size: 18,
                                          ),
                                          Text("Role : ",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: AppColors
                                                          .PrimaryDarkColor,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 14))),
                                          Text(
                                              "${userList[index].lastName ?? ""}",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: AppColors
                                                          .PrimaryDarkColor,
                                                      fontSize: 14))),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),

                                      SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.phone,
                                            color: AppColors.colorAccent,
                                            size: 18,
                                          ),
                                          Text("Phone Number",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: AppColors
                                                          .PrimaryDarkColor,
                                                      fontSize: 14))),
                                          Text(
                                              "${userList[index].phoneNumber ?? ""}",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: AppColors
                                                          .PrimaryDarkColor,
                                                      fontSize: 14))),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    )));
          });
    });
  }

  void deleteWidget(BuildContext context, int index, initialState) {
    AwesomeDialog(
      context: context,
      keyboardAware: true,
      dismissOnBackKeyPress: false,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      btnCancelText: "CANCEL",
      btnCancelColor: AppColors.green,
      btnOkText: "REMOVE",
      btnOkColor: AppColors.red,
      title: 'REMOVE ' + "${userList[index].firstName ?? ""}",
      padding: const EdgeInsets.all(16.0),
      desc: 'Are you sure you want to remove user',
      btnCancelOnPress: () {},
      btnOkOnPress: () async {

          Fluttertoast.showToast(
              msg: 'to remove user',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: AppColors.red,
              textColor: AppColors.whitish,
              fontSize: 14.0);

      },
    ).show();
  }

  void removeUser(int index, initialState) {
    initialState(() {
      userList = List.from(userList)..removeAt(index);
    });
  }
}
void saveUser(BuildContext context, User user) async {
  DatabaseHelper databaseHelper = DatabaseHelper();


 //   user.userID = DateFormat.HOUR_MINUTE_SECOND+DateFormat.DAY; //usedDateFormat n seconds to generateUnique UserID
    await databaseHelper.addUser(user);

  _showSnackBar(context, user.firstName + ' successfully added');
}

void _showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
      content: Text(
        message,
        style:
        GoogleFonts.poppins(textStyle: TextStyle(color: AppColors.white)),
      ),
      backgroundColor: AppColors.PrimaryColor,
      behavior: SnackBarBehavior.fixed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: AppColors.colorAccent,
            width: 1,
          )));

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}