import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:device_info/device_info.dart';
import 'package:gods_eye/DataClass/dataClass.dart';
import 'package:gods_eye/LocalStorage/userData.dart';
import 'package:gods_eye/SendData/sendData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GodsEye {
  final String godsEyeID;
  GodsEye({required this.godsEyeID});

  Future<void> start() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? storedUserData1;

    DataClass content1;

    storedUserData1 = preferences.getString("UserData1");
    if (storedUserData1 == null) {
      // LOCATION
      double longitude;
      double latitude;
      double altitude;
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        permission = await Geolocator.requestPermission();
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      Position position = await Geolocator.getCurrentPosition();
      longitude = position.longitude;
      latitude = position.longitude;
      altitude = position.longitude;

      // DEVICE INFO
      late String deviceOS;
      late String deviceModel;
      late String deviceID;
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        deviceOS = 'Android';
        AndroidDeviceInfo androidDeviceInfo =
            await deviceInfoPlugin.androidInfo;
        deviceModel = androidDeviceInfo.model;
        deviceID = androidDeviceInfo.androidId;
      } else if (Platform.isIOS) {
        deviceOS = 'IOS';
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        deviceModel = iosInfo.utsname.machine;
        deviceID = iosInfo.identifierForVendor;
      }

      // MAKE CLASS
      DataClass one = DataClass(
        godsEyeID: godsEyeID,
        latitude: latitude.toString(),
        longitude: longitude.toString(),
        altitude: altitude.toString(),
        deviceOS: deviceOS,
        deviceModel: deviceModel,
        deviceID: deviceID,
        numOfTimesOpened: 1,
        timeSpend: 0,
        feedback: 'nill',
      );

      //TO LOCAL STORAGE 1
      await setUserData1(one: one);
    } else {
      Map<String, dynamic> userMap1 = jsonDecode(storedUserData1);
      content1 = DataClass.fromJson(userMap1);

      //Increase count
      int oldCount = content1.numOfTimesOpened;
      content1.numOfTimesOpened = oldCount + 1;
      await setUserData1(one: content1);

      Timer.periodic(Duration(minutes: 1), (timer) async {
        int oldTime = content1.timeSpend;
        content1.timeSpend = oldTime + 1;
        await setUserData1(one: content1);
      });
    }

    await checkNewDataToSendData();
  }
}
