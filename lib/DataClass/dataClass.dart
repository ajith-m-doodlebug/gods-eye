class DataClass {
  final String godsEyeID;
  final String latitude;
  final String longitude;
  final String altitude;
  final String deviceOS;
  final String deviceModel;
  final String deviceID;
  int numOfTimesOpened;
  int timeSpend;
  String feedback;

  DataClass({
    this.godsEyeID = '',
    this.latitude = '',
    this.longitude = '',
    this.altitude = '',
    this.deviceOS = '',
    this.deviceModel = '',
    this.deviceID = '',
    this.numOfTimesOpened = 0,
    this.timeSpend = 0,
    this.feedback = '',
  });

  DataClass.fromJson(Map<String, dynamic> json)
      : godsEyeID = json['godsEyeID'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        altitude = json['altitude'],
        deviceOS = json['deviceOS'],
        deviceModel = json['deviceModel'],
        deviceID = json['deviceID'],
        numOfTimesOpened = int.parse(json['numOfTimesOpened']),
        timeSpend = int.parse(json['timeSpend']),
        feedback = json['feedback'];

  Map<String, dynamic> toJson() => {
        'godsEyeID': godsEyeID,
        'latitude': latitude,
        'longitude': longitude,
        'altitude': altitude,
        'deviceOS': deviceOS,
        'deviceModel': deviceModel,
        'deviceID': deviceID,
        'numOfTimesOpened': numOfTimesOpened.toString(),
        'timeSpend': timeSpend.toString(),
        'feedback': feedback,
      };
}
