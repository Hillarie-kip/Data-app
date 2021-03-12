# SHAMBA APP DATA 



## Table of contents

- [User Registration](#description)
- [User List](#onboarding-module)
- [Attendants Registry](#patient-module)
- [ Admin GPS Location](#doctor-module)



## Dependencies
  sqflite: any
  - to minimize communication to server as data can be stored locally and transmitted when there is a connection
  
  google_fonts: ^1.1.1
  - to beautify text
 
  intl: ^0.17.0-nullsafety.2
  - Provides internationalization and localization facilities
  
  fluttertoast: ^7.1.8
  - just a toast style (not a must)
  
  google_maps_flutter: ^1.0.6
  geolocator: ^6.1.13
  geocoder: ^0.2.1
  location: ^3.0.2
  
  - the above 4 dependencies is to provide most out of the geospatial data
  
  awesome_dialog: ^1.2.0
   - pop up dialog
  


## Description

The purpose of the test is to complete the named task with clean and minimum library dependencies in the project to avoid depending on someones code.
 Uses Sqlite database for offline running..once complete app will send data is JSON Format i.e
 
 ```json
{
"AdminID":1,
"AttendanceID":682,
"Present":3,
"Absent":3,
"AttendanceDate":"2020-03-12",
"AttendantList":[
                {
                "UserID":1,
                "ReportID":682
                 },
                 {
                "UserID":2,
                "ReportID":682
                 },
                 {
                "UserID":3,
                "ReportID":682
                 }
                
                ]
}
```


## Screen Module


1
![Registration](scrrenshots/register.png)

2
![User-List](scrrenshots/users.png)
2
![Attendant-List](scrrenshots/Attendants.png)
2
![Submit-List](scrrenshots/location.png)


## Author Info

- Name: Hillarie Kalya
- Email : kalyahillary@gmail.com
