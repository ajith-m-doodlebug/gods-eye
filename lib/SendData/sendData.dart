import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../LocalStorage/userData.dart';
import '../DataClass/dataClass.dart';
import 'package:time/time.dart';

checkNewDataToSendData() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  final DateTime nowTime = DateTime.now();
  final DateTime stopTime = DateTime.now() + Duration(hours: 24);
  late DateTime endTime;

  String? storedUserData1;
  String? storedUserData2;

  var content1;
  var content2;

  storedUserData1 = preferences.getString("UserData1");
  Map<String, dynamic> userMap1 = jsonDecode(storedUserData1!);
  content1 = DataClass.fromJson(userMap1);

  storedUserData2 = preferences.getString("UserData2");
  if (storedUserData2 == null) {
    content2 = DataClass(numOfTimesOpened: 0, timeSpend: 0, feedback: '');
    await setEndTime(time: stopTime);
  } else {
    Map<String, dynamic> userMap2 = jsonDecode(storedUserData2);
    content2 = DataClass.fromJson(userMap2);
  }

  String? gotTime = preferences.getString("EndTime");
  endTime = DateTime.parse(gotTime.toString());

  if (nowTime.isBefore(endTime)) {
    if (content1.numOfTimesOpened != content2.numOfTimesOpened ||
        content1.timeSpend != content2.timeSpend ||
        content1.feedback != content2.feedback) {
      var response = await http.get(Uri.parse(
          'https://gods-eye-doodlebug.herokuapp.com/ProjectOne/put/${content1.godsEyeID}/${content1.deviceID}/$storedUserData1'));
      await setUserData2(one: content1);
    }
  }
}
