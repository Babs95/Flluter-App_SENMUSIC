import 'package:flutter/material.dart';
import 'package:quizzgame_app/widgets/custom_text.dart';
import 'package:quizzgame_app/widgets/page_quizz.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        leading: Icon(Icons.account_circle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Card(
              elevation: 10.0,
              child: Container(
                height: MediaQuery.of(context).size.width * 0.8,
                width: MediaQuery.of(context).size.width * 0.8,
                 child: Image.asset('quizz_assets/quizz.png',
                    fit: BoxFit.cover,),
              ),
            ),
            RaisedButton(
              color: Colors.amber[600],
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                  return new PageQuizz();
                }));
              },
              child: CustomText('Commencer le quizz',
              factor: 1.5,)
              ,)
          ],
        ),
      ),
    );
  }
}