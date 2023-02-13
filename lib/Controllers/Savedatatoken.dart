import 'package:shared_preferences/shared_preferences.dart';

void doneFetchcontact(checker) async {
  final prefs = await SharedPreferences.getInstance();

  prefs.setBool('fetchcontact', checker);
}

Future<dynamic> checkFetchcontact() async {
  final prefs = await SharedPreferences.getInstance();

  var token = (prefs.getBool('fetchcontact') ?? 'false');

  return token;
}