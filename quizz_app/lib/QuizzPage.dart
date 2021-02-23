import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizz_app/ResultPage.dart';


class getjson extends StatelessWidget {
 String langname;
 getjson(this.langname);
 String assetToLoad;
 setasset(){
   switch(langname){
     case "Python":
       assetToLoad="assets/python.json";
       break;
     case "C++":
       assetToLoad="assets/C++.json";
       break;
     case "Object Oriented Programming":
       assetToLoad="assets/oop.json";
       break;
     case "JavaScript":
       assetToLoad="assets/javaScript.json";
       break;
     case "Java":
       assetToLoad="assets/java.json";
       break;
   }
 }

  @override
  Widget build(BuildContext context) {
    setasset();
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString(assetToLoad),
      builder: (context, snapshot) {
        List myData = json.decode(snapshot.data.toString());
        if (myData == null) {
          return Scaffold(
            body: Center(
              child: Text(
                "Loading",
              ),
            ),
          );
        } else {
          return quizzPage(myData:myData);
        }
      },
    );
  }
}

class quizzPage extends StatefulWidget {
  final List myData;
  quizzPage({Key key, @required this.myData}):super(key:key);
  @override
  _quizzPageState createState() => _quizzPageState(myData);
}

class _quizzPageState extends State<quizzPage> {
  final List myData;

  _quizzPageState(this.myData);

  Color colorToShow=Colors.indigoAccent;
  Color rightAns = Colors.green;
  Color wrongAns = Colors.red;
  int marks = 0;
  int i = 1;
  bool disableAnswer = false;
  int j = 1;
  int timer = 30;
  String showTimer = "30";
  var random_array;

  Map<String, Color> btncolor= {
    "a": Colors.indigoAccent,
    "b": Colors.indigoAccent,
    "c": Colors.indigoAccent,
    "d": Colors.indigoAccent,
  };

  bool cancelTimer = false;


  genRandomArray(){
    var distinctIds = [];
    var rand = new Random();
    for (int i = 0; i < 10; ++i) {
      distinctIds.add(i);
      random_array = distinctIds.toSet().toList();
    }
  }


 @override
  void initState(){
    startTimer();
    genRandomArray();
    super.initState();
  }


  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void startTimer() async{
    const onesec=Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t){
      setState(() {
        if(timer<1){
          t.cancel();
          nextQuestion();
        }else if(cancelTimer==true){
          t.cancel();
        }
        else{
          timer=timer-1;
        }
        showTimer=timer.toString();
      });
    });
  }
  void nextQuestion(){
   cancelTimer=false;
   timer=30;
    setState(() {
      if(j < 10){
        i = random_array[j];
        j++;
      }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => resultpage(marks: marks),
      ));

      }
      btncolor["a"]=Colors.indigoAccent;
      btncolor["b"]=Colors.indigoAccent;
      btncolor["c"]=Colors.indigoAccent;
      btncolor["d"]=Colors.indigoAccent;
    });
    startTimer();
  }
  void checkAnswer(String k){
       if(myData[2][i.toString()]==myData[1][i.toString()][k]){
        marks=marks+5;
        colorToShow=rightAns;
       }
       else{
         colorToShow=wrongAns;
       }
       setState(() {
          btncolor[k]=colorToShow;
          cancelTimer=true;
       });
      Timer(Duration(seconds: 2), nextQuestion);
  }
  Widget choicebutton(String k){
    return Padding(
     padding: EdgeInsets.symmetric(
       vertical: 10.0,
       horizontal: 20.0,
     ),
      child: MaterialButton(
        onPressed: () =>checkAnswer(k),
        child: Text(
          myData[1][i.toString()][k],
            style: TextStyle(
            color: Colors.white,
              fontFamily: "01435_AlexAntiquaBook",
              fontSize: 16.0,
        ),
          maxLines: 1,
        ),
        color: btncolor[k],
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: 200.0,
        height: 45.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
   SystemChrome.setPreferredOrientations([
     DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
   ]);
    return WillPopScope(
      onWillPop: (){
        return showDialog(
          context: context,
          builder: (context)=>AlertDialog(
            title: Text(
              "Quiz",
            ),
            content: Text(
              "You can't go back at this stage."
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Ok",
                ),
              )
            ],
          ),
        );
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  myData[0][i.toString()],
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "01435_AlexAntiquaBook",
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 6,
              child: Container(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    choicebutton('a'),
                    choicebutton('b'),
                    choicebutton('c'),
                    choicebutton('d'),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Text(
                    showTimer,
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: "01435_AlexAntiquaBook",
                    ),
                  ),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}


