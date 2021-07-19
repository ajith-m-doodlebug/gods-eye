import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gods_eye/DataClass/dataClass.dart';
import 'package:gods_eye/LocalStorage/userData.dart';
import 'package:gods_eye/SendData/sendData.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Color kColorOne = Color(0xFF00E2EE);

class GodsEyeFeedback extends StatefulWidget {
  @override
  _GodsEyeFeedbackState createState() => _GodsEyeFeedbackState();
}

class _GodsEyeFeedbackState extends State<GodsEyeFeedback> {
  final _feedback = TextEditingController();

  late DataClass content1;
  String? storedUserData1;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    storedUserData1 = preferences.getString("UserData1");
    try {
      setState(() {
        Map<String, dynamic> userMap1 = jsonDecode(storedUserData1!);
        content1 = DataClass.fromJson(userMap1);
      });
    } catch (e) {}
  }

  _setData() async {
    content1.feedback = _feedback.text;
    await setUserData1(one: content1);
    await checkNewDataToSendData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
          title: Text(
            'Feedback',
            style: TextStyle(color: kColorOne),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Please share your thoughts about this new application.',
                style: TextStyle(
                  fontSize: 23,
                  color: kColorOne,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            InputField(
              controller: _feedback,
              hintText: '......',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter the e-mail id';
                }
                return null;
              },
              maxLength: 80,
              maxLines: 4,
            ),
            Row(
              children: [
                LongButton(
                  text: 'Skip',
                  textColor: kColorOne,
                  buttonColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                LongButton(
                  text: 'Submit',
                  textColor: Colors.white,
                  buttonColor: kColorOne,
                  onPressed: () async {
                    await _setData();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LongButton extends StatefulWidget {
  final String text;
  final Color textColor;
  final Color buttonColor;
  final VoidCallback? onPressed;

  const LongButton({
    required this.text,
    required this.textColor,
    required this.buttonColor,
    required this.onPressed,
  });

  @override
  _LongButtonState createState() => _LongButtonState();
}

class _LongButtonState extends State<LongButton> {
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.disabled,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.black;
      }
      return widget.buttonColor;
    }

    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width / 2,
      height: 65.0,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(getColor),
        ),
        onPressed: widget.onPressed,
        child: Text(
          widget.text,
          style: TextStyle(color: widget.textColor, fontSize: 20.0),
        ),
      ),
    );
  }
}

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function? validator;
  final int maxLines;
  final int maxLength;

  const InputField({
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.maxLines,
    required this.maxLength,
  });
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  var val;
  @override
  void initState() {
    val = widget.validator;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        controller: widget.controller,
        validator: val == null ? null : val,
        cursorColor: Colors.black87,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kColorOne, width: 3.0),
          ),
          //Error
        ),
      ),
    );
  }
}
