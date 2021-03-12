import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shamba_app/common/constants.dart';
import 'package:shamba_app/common/llocations/LocationInput.dart';
import 'package:shamba_app/common/llocations/place.dart';
import 'package:shamba_app/models/User.dart';

import 'package:shamba_app/utils/DatabaseHelper.dart';

import 'package:sqflite/sqflite.dart';



class UserAttendanceScreen extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return UserAttendanceScreenState();
  }
}

class UserAttendanceScreenState extends State<UserAttendanceScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<User> userList;
  int count = 0;
  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();
  ScrollController scrollController = ScrollController();
  bool isCheck=false;

  PlaceLocation _pickedLocation;

  double fromLocationLatitude = 0.0;
  double fromLocationLongitude = 0.0;
 String fromLocation;




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
          title: Text("Attendance"),),
      body:Column(
        children: <Widget>[
          Expanded(
            child: userList != null
                ? new UserView(
                userList: userList)
                : userList == null
                ? new Center(child: new CircularProgressIndicator())
                : new Center(
              child: new Text("No Users ADD Users!"),
            ),
          )
        ],
      ),
      floatingActionButton:

      FloatingActionButton.extended(
        onPressed: () {
          uploadAttendants(context,userList);
        },
        label: Text('Submit Attendance',
            style: GoogleFonts.poppins(
                textStyle: TextStyle(color: Colors.white, fontSize: 16))),
        icon: Icon(
          Icons.supervised_user_circle,
          color: Colors.orange,
        ),
        backgroundColor: AppColors.PrimaryDarkColor,
      ),


    );
  }

  uploadAttendants(BuildContext context, List<User> userList) async {
    return showGeneralDialog(
      barrierLabel: "Shamba",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter mystate) {
              return Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 30,
                    right: 10,
                    bottom: 50,
                  ),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: new Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 10,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                LocationInput(_selectPlaceFrom),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Here will display Logged In User info for admin",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.PrimaryDarkColor)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),


                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 45,
                                  child: RaisedButton(
                                      child: Text('SUBMIT'),
                                      color: AppColors.PrimaryDarkColor,
                                      textColor: Colors.white,
                                      onPressed: () async {
                                        if (fromLocationLatitude == 0.0 ) {
                                          Fluttertoast.showToast(
                                              msg:
                                              "Tap to get Current Location",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: AppColors.red,
                                              textColor: Colors.white,
                                              fontSize: 14.0);
                                        } else {

// ON Submit to database it will sent json object with an array of user attendance
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)))),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ));
            });
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
          Tween(begin: Offset(0, -1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }
  Future<void> _selectPlaceFrom(double lat, double lng) async {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
    fromLocationLatitude = _pickedLocation.latitude;
    fromLocationLongitude = _pickedLocation.longitude;
    final coordinates =
    new Coordinates(_pickedLocation.latitude, _pickedLocation.longitude);
    var addresses =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    fromLocation = "${first.featureName} : ${first.addressLine}";
  }



   void updateList() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<User>> userListFuture =
          databaseHelper.getUserList();
      userListFuture.then((noteList) {
        setState(() {
          this.userList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }











}
class UserView extends StatelessWidget {
 List<User> userList;

  bool isCheck=false;

  UserView( {Key key, this.userList}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return StatefulBuilder(builder: (BuildContext context, initialState) {
      return ListView.builder(
          itemCount: userList == null ? 0 : userList.length,
          itemBuilder: (BuildContext context, int index) {
            if(userList[index].isCheck==1){
              isCheck=true;
            }else{
              isCheck=false;
            }

            return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: AppColors.white,
                elevation: 10,
                child: Container(

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

                                InkWell(
                                    onTap: () {
                                      deleteWidget(
                                          context, index, initialState);
                                    },
                                    child: Container(

                                      child:
                                      new Row(children: [
                                          Text("check if present", style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: AppColors
                                                      .PrimaryDarkColor,
                                                  fontSize: 14))),

            Checkbox(value: isCheck, onChanged: (bool val) {
              initialState(() {
                isCheck=val;
                if(isCheck){
                  updateItem(index,initialState,1);
                  UpdateAttrendant(context,userList[index].firstName,userList[index].userID,1);

                }else{
                  updateItem(index,initialState,0);
                  UpdateAttrendant(context,userList[index].firstName,userList[index].userID,0);

                }
                });
            })
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
                                          Text("ID : ",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: AppColors
                                                          .PrimaryDarkColor,
                                                      fontSize: 14))),
                                          Text(
                                              "${userList[index].userID ?? ""}",
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
                                          Text("User : ",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: AppColors
                                                          .PrimaryDarkColor,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 14))),
                                          Text(
                                              "${userList[index].firstName+' '+userList[index].lastName ?? ""}",
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
                                      userList[index].isCheck==1?
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.timelapse_outlined,
                                            color: AppColors.colorAccent,
                                            size: 18,
                                          ),
                                             Text(
                                              "Present",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: AppColors
                                                          .PrimaryDarkColor,
                                                      fontSize: 14))),
                                        ],
                                      ):
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.timelapse_outlined,
                                            color: AppColors.colorAccent,
                                            size: 18,
                                          ),
                                          Text(
                                              "Absent",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: AppColors
                                                          .red,
                                                      fontSize: 14))),
                                        ],
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
 void updateItem(int index, initialState, int isCheck) {
   initialState(() {
     userList[index].isCheck = isCheck;
   });
 }
  void UpdateAttrendant(BuildContext context, String firstName,String userID, int isCheck) async {

   DatabaseHelper databaseHelper = DatabaseHelper();
   //   user.userID = DateFormat.HOUR_MINUTE_SECOND+DateFormat.DAY; //usedDateFormat n seconds to generateUnique UserID
   await databaseHelper.updateUser(userID,isCheck);
if(isCheck==1){
  _showSnackBar(context,  firstName + ' marked present');
}else
   _showSnackBar(context,  firstName + ' marked absent');
 }
  void removeUser(int index, initialState) {
    initialState(() {
      userList = List.from(userList)..removeAt(index);
    });
  }
}
void saveUser(BuildContext context,User user ) async {
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