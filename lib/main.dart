import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'CLR',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(children: <Widget>[
        Expanded(
            child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userQuestion,
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userAnswer,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        )),
        Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButton(
                          buttonTapped: () {
                            setState(() {
                              userQuestion = '';
                            });
                          },
                          color: Colors.green[400],
                          textColor: Colors.white,
                          buttonText: buttons[index]);
                    } else if (index == 1) {
                      return MyButton(
                          buttonTapped: () {
                            setState(() {
                              userQuestion = userQuestion.substring(
                                  0, userQuestion.length - 1);
                            });
                          },
                          color: Colors.red,
                          textColor: Colors.white,
                          buttonText: buttons[index]);
                    } else if (index == buttons.length - 1) {
                      return MyButton(
                          buttonTapped: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                          buttonText: buttons[index]);
                    } else if (index == buttons.length - 2) {
                      return MyButton(
                          buttonTapped: () {
                            setState(() {
                              userQuestion = '';
                              userAnswer = '';
                            });
                          },
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                          buttonText: buttons[index]);
                    } else {
                      return MyButton(
                          buttonTapped: () {
                            setState(() {
                              userQuestion += buttons[index];
                            });
                          },
                          color: isOperator(buttons[index])
                              ? Colors.deepPurple
                              : Colors.deepPurple[50],
                          textColor: isOperator(buttons[index])
                              ? Colors.white
                              : Colors.deepPurple,
                          buttonText: buttons[index]);
                    }
                  }),
            ))
      ]),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    } else {
      return false;
    }
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
