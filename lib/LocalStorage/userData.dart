import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../DataClass/dataClass.dart';

setUserData1({required DataClass one}) async {
  SharedPreferences userDetail = await SharedPreferences.getInstance();
  String jsonTags = jsonEncode(one);
  await userDetail.setString("UserData1", jsonTags);
}

setUserData2({required DataClass one}) async {
  SharedPreferences userDetail = await SharedPreferences.getInstance();
  String jsonTags = jsonEncode(one);
  await userDetail.setString("UserData2", jsonTags);
}

removeUserData1() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.remove("UserData1");
}

removeUserData2() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.remove("UserData2");
}

setEndTime({required DateTime time}) async {
  SharedPreferences endTime = await SharedPreferences.getInstance();
  await endTime.setString("EndTime", time.toString());
}
