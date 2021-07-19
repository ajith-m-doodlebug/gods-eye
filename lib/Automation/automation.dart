import '../SendData/sendData.dart';
import 'package:workmanager/workmanager.dart';

const simpleTaskKey = "simpleTask";
const simplePeriodicTask = "simplePeriodicTask";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case simpleTaskKey:
        await checkNewDataToSendData();
        break;
      // case simplePeriodicTask:
      //   await checkNewDataToSendData();
      //   break;
    }
    return Future.value(true);
  });
}

class Automation {
  Automation();

  void startAutomation() {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );

    Workmanager()
        .registerOneOffTask("1", simpleTaskKey, inputData: <String, dynamic>{
      'string': '',
    });

    // Workmanager().registerPeriodicTask(
    //   "2",
    //   simplePeriodicTask,
    //   frequency: Duration(seconds: 40),
    //   inputData: <String, dynamic>{
    //     'string': "",
    //   },
    // );
  }

  void endAutomation() {
    Workmanager().cancelByUniqueName(simpleTaskKey);
  }
}
