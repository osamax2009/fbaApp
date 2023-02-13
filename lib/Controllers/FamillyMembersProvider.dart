// import 'package:fba/Controllers/SendData.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/foundation.dart';
//
// import 'User.dart';
//
// class FamillyMembersProvider with ChangeNotifier, DiagnosticableTreeMixin {
//
//   List<User>  get familyList {
//     var _familyList ;
//      getFamily().then(
//           (value) => _familyList = value
//       );
//      return _familyList;
//   }
//
//
//   Future<List<User>> getFamily() async {
//     var mylist;
//     SendData sendData = SendData();
//     var token ;
//     await  sendData.getToken().then(
//              (value) => token = value
//      );
//     print("token $token");
//    var data = {
//      'token': token
//    };
//   await  sendData.getthefamilymembers(data).then(
//            (value) => mylist) ;
//
//
//
//    return mylist;
//   }
//
//
//
//
//   // /// Makes `Counter` readable inside the devtools by listing all of its properties
//   // @override
//   // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//   //   super.debugFillProperties(properties);
//   //   properties.add(strProperty('count', familyList));
//   // }
// }