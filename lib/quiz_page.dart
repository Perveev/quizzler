import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreList = [];


  QuizBrain quizBrain = QuizBrain();


  void checkAnswer(bool userAnswer, BuildContext context) {
    bool correctAnswer = quizBrain.getQuestionAnswer();

    if (quizBrain.isFinished()) {
      Alert(
        context: context,
        title: 'Finished',
        desc: 'You reached the end of the quiz',
      ).show();
      quizBrain.reset();
      scoreList.clear();
    } else {
      if (userAnswer == correctAnswer) {
        scoreList.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scoreList.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
      quizBrain.nextQuestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              color: Colors.green,
              child: TextButton(
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    checkAnswer(true, context);
                  });
                  //The user picked true.
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              color: Colors.red,
              child: TextButton(
                child: Text(
                  'False',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    checkAnswer(false, context);
                  });
                  //The user picked true.
                },
              ),
            ),
          ),
        ),
        Row(
          children: scoreList,
        )
      ],
    );
  }
}
