

class User {

  int _id;
  String _userID;
  String _firstName;
  String _lastName;
  String _phoneNumber;
  int _isCheck;
  String _attendantsDate;


  User(
      this._userID,
      this._firstName,
      this._phoneNumber,
      this._lastName,
      this._isCheck,
      this._attendantsDate

      );

  User.withId(this._id,
      this._userID,
      this._firstName,
      this._lastName,
      this._phoneNumber,
      this._isCheck,
      this._attendantsDate,
     );

  int get id => _id;
  String get userID => _userID;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get phoneNumber => _phoneNumber;
  int get isCheck=> _isCheck;
  String get attendantsDate => _attendantsDate;



  set userID(String userID) {
    this._userID = userID;
  }
  set isCheck(int isCheck) {
    this._isCheck = isCheck;
  }

  set attendantsDate(String attendantsDate) {
    this._attendantsDate = attendantsDate;
  }


  set lastName(String lastName) {
      this._lastName = lastName;

  }

  set firstName(String firstName) {
    this._firstName = firstName;
  }

  set phoneNumber(String phoneNumber) {
    this._phoneNumber = phoneNumber;
  }





  // Converting a  object 2 a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['ID'] = _id;
    }
    map['UserID'] = _userID;
    map['PhoneNumber'] = _phoneNumber;
    map['FirstName'] = _firstName;
    map['LastName'] = _lastName;
    map['IsCheck'] = _isCheck;
    map['AttendantDate'] = _attendantsDate;
    return map;
  }

  // Extract a  object from a Mapobject
  User.fromMapObject(Map<String, dynamic> map) {
    this._id = map['ID'];
    this._userID = map['UserID'];
    this._phoneNumber = map['PhoneNumber'];
    this._lastName = map['LastName'];
    this._firstName = map['FirstName'];
    this._isCheck = map['IsCheck'];
    this._attendantsDate = map['AttendantDate'];



  }

// make it to json object incase send to server ama any other storrage kama JSON
  Map<String, dynamic> toJson() {
    return {
      'UserID': this._userID,
      'FirstName': this._firstName,
      'LastName': this._lastName,
      'PhoneNumber': this._phoneNumber,
      'DateTime': DateTime.now().toString(),
    };
  }


}













