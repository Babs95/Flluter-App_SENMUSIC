import 'package:flutter/material.dart';
import 'custom_text.dart';
import 'package:quizzgame_app/models/Question.dart';

class PageQuizz extends StatefulWidget {
  @override
  _PageQuizzState createState() => new _PageQuizzState();
  

}

class _PageQuizzState extends State<PageQuizz> {

  Question question;
  List<Question> listeQuestions = [
    new Question('La devise de la Belgique est l\'union fait la force', true, '', 'belgium.png'),
    new Question('La lune va finir par tomber sur terre à cause de la gravité', false, 'Au contraire la lune s\'éloigne', 'lune.jpg'),
    new Question('La Russie est plus grande en superficie que Pluton', true, '', 'russie.jpg'),
    new Question('Nyctalope est une race naine d\'antilope', false, 'C\'est une aptitude à voir dans le noir', 'nyctalope.png'),
    new Question('Le Commodore 64 est l\'ordinateur le plus vendu', true, '', 'Commodore64.png'),
    new Question('Le nom du drapeau des pirates est black skull', false, 'Il est appelé Jolly Roger', 'pirates.jpg'),
    new Question('Maddock est le nom du chien de Tintin faussein', false, 'Il s\'appelle Milou', 'Tintin.jpg'),
    new Question('La barbe des pharaons était', true, 'A l\'époque déjà ils utilisaient des postiches', 'pharaon.jpg'),

  ];

  int index = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    question = listeQuestions[index];
  }
  @override
  Widget build(BuildContext context) {
    double taille = MediaQuery.of(context).size.width * 0.75;
    return new Scaffold(
      appBar: AppBar(
        title: CustomText('Le Quizz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CustomText('Question ${index +1}', color: Colors.grey[900],factor: 1.5,),
            CustomText('Score: $score / $index', color: Colors.grey[900],),
            Card(
              elevation: 10.0,
              child: Container(
                height: taille,
                width: taille,
                child: Image.asset(
                    'quizz_assets/${question.imagePath}',
                fit: BoxFit.cover,
                ),
              ),
            ),
            CustomText(question.question, color: Colors.grey[900],factor: 1.5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buttonBool(true),
                buttonBool(false)
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  RaisedButton buttonBool (bool b) {
    return new RaisedButton(
      elevation: 15.0,
      onPressed: (() => dialogue(b)),
      color: Colors.amber,
      child: CustomText((b) ? 'Vrai' : 'Faux', factor: 1.5, color: Colors.black,),
    );
  }

  Future<Null> dialogue(bool b) async {
    bool bonneReponse = (b == question.reponse);
    String vrai = 'quizz_assets/bravo.jpg';
    String faux = 'quizz_assets/ratee.jpeg';
    if(bonneReponse){
      score++;
    }
    return showDialog(
        context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
          return SimpleDialog(
            title: CustomText((bonneReponse)? "C'est gagné!!":"Oohhh!!! perdu...", factor: 1.6,color: (bonneReponse)?Colors.green:Colors.red),
            contentPadding: EdgeInsets.all(20.0),
            children: <Widget>[
              Image.asset((bonneReponse)? vrai: faux, fit: BoxFit.cover,),
              Container(height: 25.0,),
              CustomText(question.explication, factor: 1.5, color: Colors.grey[900],),
              Container(height: 25.0,),
              RaisedButton(
                color: Colors.amber,
                onPressed: () {
                Navigator.pop(context);
                questionSuivante();
              },
              child: CustomText('Au suivant', factor: 1.25,
              color: Colors.black,),)
            ],
          );
      }
    );
  }

  Future<Null> alerte() async {
    return showDialog(
        context: context,
    barrierDismissible: false,
    builder: (BuildContext buildcontext) {
          return AlertDialog(
            title: CustomText("C'est fini", color: Colors.amber,factor: 1.5,),
            contentPadding: EdgeInsets.all(10.0),
            content: CustomText("Votre score: $score / $index",color: Colors.grey[900],),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(buildcontext);
                  Navigator.pop(context);
                },
                child: CustomText('Ok', color: Colors.amber,factor: 1.25,),
              )
            ],
          );
    });
  }
  void questionSuivante() {
    if(index <listeQuestions.length - 1) {
      index++;
      setState(() {
        question = listeQuestions[index];
      });
    } else {
        alerte();
    }

  }
}