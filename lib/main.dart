import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.amber[900],
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var result = "";
  String equation = "";

  clear() {
    setState(() {
      equation = "";
      result = "";
    });
  }

  output() {
    if (equation.length == 0) {
      return;
    }
    String parsedEquation;
    parsedEquation = equation.replaceAll('×', '*');
    parsedEquation = parsedEquation.replaceAll('÷', '/');
    parsedEquation = parsedEquation.replaceAll('−', '-');
    Parser p = Parser();
    Expression exp = p.parse(parsedEquation);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      result = eval.toStringAsFixed(0);
    });
  }

  void remove() {
    setState(() {
      equation = equation.length == 0
          ? equation
          : equation.substring(0, equation.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: Icon(Icons.calculate_rounded, size: 45, color: Colors.amber[900]),
        title: Text(widget.title,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 25.0)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 100.0, 35.0, 5.0),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    equation,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.grey, fontSize: 21),
                  )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 15.0),
                  child: Text(result,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 45,
                        color: Colors.blueGrey[800],
                      )),
                ),
              ],
            ),
            Divider(
              thickness: 2,
              height: 2,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 3,
                      ),
                      Container(
                        width: 85,
                        height: 78,
                        color: Colors.transparent,
                        child: MaterialButton(
                          onPressed: clear,
                          child: Text('C',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.amber[900],
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      btn('%'),
                      btn('÷'),
                      SizedBox(
                        width: 20.0,
                      ),
                      IconButton(
                        onPressed: remove,
                        icon: Icon(Icons.backspace_outlined,
                            color: Colors.amber[900]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      btn('7'),
                      btn('8'),
                      btn('9'),
                      btn('×'),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      btn('4'),
                      btn('5'),
                      btn('6'),
                      btn('−'),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [btn('1'), btn('2'), btn('3'), btn('+')],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      btn('00'),
                      btn('0'),
                      btn('.'),
                      SizedBox(
                        width: 2,
                      ),
                      Container(
                        width: 85,
                        height: 78,
                        color: Colors.transparent,
                        child: MaterialButton(
                          onPressed: output,
                          child: Text('=',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.amber[900],
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget btn(String value) {
    return Container(
      alignment: Alignment.center,
      width: 90,
      height: 80,
      child: MaterialButton(
        minWidth: 84,
        height: 79,
        onPressed: () {
          setState(() {
            equation += value;
          });
        },
        child: Text(value,
            style: TextStyle(
              fontSize: 30,
              color: value == '+' ||
                      value == '−' ||
                      value == '×' ||
                      value == '÷' ||
                      value == '%'
                  ? Colors.amber[900]
                  : Colors.black,
              fontWeight: FontWeight.w400,
            )),
      ),
    );
  }
}
