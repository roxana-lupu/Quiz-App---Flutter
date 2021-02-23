import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'QuizzPage.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  List<String> images =[
    "images/oop2.jpg",
    "images/java.png",
    "images/javas.png",
    "images/python.png",
    "images/c++.jpg",
  ];

  Widget customcard(String languageName, String image){
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => getjson(languageName),
          ));
        },
        child: Material(
          color: Colors.teal,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(

                      height: 200.0,
                      width: 200.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image(
                          image: AssetImage(
                            image,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    languageName,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontFamily: "AabcedBoldItalic",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PROGRAMMING",
          style: TextStyle(
            fontSize: 45.0,
            fontFamily: "01435_AlexAntiquaBook",
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          customcard("Object Oriented Programming", images[0]),
          customcard("Java", images[1]),
          customcard("JavaScript", images[2]),
          customcard("Python", images[3]),
          customcard("C++", images[4]),
        ],
      ),
    );
  }
}