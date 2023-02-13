import 'package:intl/intl.dart';


String  getTheDate(inputdate){

   final DateFormat formatter = DateFormat('yyyy-MM-dd');
   final String formatted = formatter.format(DateTime.parse(inputdate));
   print("${DateTime.parse(formatted)} the days ${DateTime.now().compareTo(DateTime.parse(formatted))}");
   if ((DateTime.now()).difference(DateTime.parse(inputdate)).inHours < 1 ) {
     return "just now";}
   else if  ((DateTime.now()).difference(DateTime.parse(inputdate)).inDays < 1 ) {
     return "${(DateTime.now()).difference(DateTime.parse(inputdate)).inHours} hours ago";}
   else if ((DateTime.now()).difference(DateTime.parse(inputdate)).inDays < 30 ) {
     return "${(DateTime.now()).difference(DateTime.parse(inputdate)).inDays} days ago";
   }else{
     return formatted;
   }

 }