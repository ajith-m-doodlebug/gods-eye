## What is God’s Eye ?

God’s Eye is used to collect data from your testers before release or your actual users after release.\
The collected data include Location, Device information, Application Usage, In-App Feedback, etc.

Before using this package, you need to create a account in [God's Eye](https://godseye-doodlebug.netlify.app/#/). \
To know about the compleate process read this [Medium Blog](https://medium.com/@ajithmanivannan1225/using-gods-eye-in-flutter-c92ffe755ad1).

## Getting started

### Step 1: Add the dependencies

```
dependencies:
  flutter:
    sdk: flutter
  gods_eye: "<newest version>"
```

### Step 2: Import gods_eye.dart

```
import 'package:gods_eye/gods_eye.dart';
```
Network permission must be added for Android and IOS.\
Location permission for Android and IOS must be added to access the location.

### Step 3: Make a function
Make this function in your main.dart file.\
The parameter godsEyeID: The God’s Eye ID you have in your Dashboard.

```

  firstFunction() async {
    GodsEye godsEye = GodsEye(godsEyeID: '###############');
    await godsEye.start();
  }

```

### Step 4: Call the function
The function must to be called in the `void initState()` of the Home Screen or the first Screen.

```

  @override
  void initState() {
    firstFunction();
    super.initState();
  }

```

### Step 5: God’s Eye Feedback
Call the Screen `GodsEyeFeedback()` where you need to get feedback from the user.

```

onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return GodsEyeFeedback();
    }),
  );
},

```

To view the compleate `main.dart` file, [click here](https://pub.dev/packages/gods_eye/example)


