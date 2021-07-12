import 'package:calculator_app/provider/theme.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _result = "";
  String _expression = "";
  String _equation = "";

  double getFullWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  double getFullHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  bool _historyOpened = false;
  _toggleButton() {
    setState(() {
      _historyOpened = !_historyOpened;
    });
  }

  formula(String text) {
    if (text != "⌫") {
      _expression = _expression + text;
    }

    _equation = _expression;
    _equation = _equation.replaceAll("÷", "/");
    _equation = _equation.replaceAll("×", "*");
    _equation = _equation.replaceAll(",", ".");

    if (text == "÷" ||
        text == "×" ||
        text == "-" ||
        text == "+" ||
        text == ",") {
    } else {
      if (_expression != "") {
        if (_expression.substring(_expression.length - 1) != "÷" &&
            _expression.substring(_expression.length - 1) != "×" &&
            _expression.substring(_expression.length - 1) != "-" &&
            _expression.substring(_expression.length - 1) != "+") {
          try {
            Parser p = Parser();
            Expression exp = p.parse(_equation);

            ContextModel cm = ContextModel();
            String str = '${exp.evaluate(EvaluationType.REAL, cm)}';
            _result = str.replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
            _result = _result.replaceAll(".", ",");
          } catch (e) {
            _result = "Error";
          }
        }
      } else {
        _result = "";
      }
    }
  }

  buttonPressed(String text) {
    setState(() {
      if (text == "C") {
        _expression = "";
        _result = "";
      } else if (text == "%") {
        _expression = _expression + text;
        if (_result == "") {
          _expression = _expression.replaceAll(",", ".");
          double _exp =
              double.parse(_expression.substring(0, _expression.length - 2));
          _result = '${(_exp / 100)}';
          _result = _result.replaceAll(".", ",");
        } else {
          _result = _result.replaceAll(",", ".");
          double _res = double.parse(_result);
          _result = '${(_res / 100)}';
          _result = _result.replaceAll(".", ",");
        }
      } else if (text == "⌫") {
        if (_expression.length > 0) {
          _expression = _expression.substring(0, _expression.length - 1);
          formula(text);
        }
      } else if (text == "÷") {
        formula(text);
      } else if (text == "×") {
        formula(text);
      } else if (text == "-") {
        formula(text);
      } else if (text == "+") {
        formula(text);
      } else if (text == "1") {
        formula(text);
      } else if (text == "2") {
        formula(text);
      } else if (text == "3") {
        formula(text);
      } else if (text == "4") {
        formula(text);
      } else if (text == "5") {
        formula(text);
      } else if (text == "6") {
        formula(text);
      } else if (text == "7") {
        formula(text);
      } else if (text == "8") {
        formula(text);
      } else if (text == "9") {
        formula(text);
      } else if (text == "0") {
        formula(text);
      } else if (text == "00") {
        formula(text);
      } else if (text == ",") {
        formula(text);
      } else if (text == "=") {
        _expression = _result;
        _result = "";
      }
    });
  }

  Widget buildButtonExpression(String buttonText) {
    return Container(
      height: 70,
      width: 70,
      // ignore: deprecated_member_use
      child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          onPressed: () {
            buttonPressed(buttonText);
          },
          child: Text(
            buttonText,
            style:
                TextStyle(color: Color.fromRGBO(20, 202, 136, 1), fontSize: 24),
          )),
    );
  }

  Widget buildButtonNumber(String buttonText) {
    return Container(
      height: 70,
      width: 70,
      // ignore: deprecated_member_use
      child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          onPressed: () {
            buttonPressed(buttonText);
          },
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(25, 25, 25, 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.scale(
                    scale: 0.5,
                    alignment: Alignment.centerLeft,
                    child: LiteRollingSwitch(
                      //initial value
                      value: false,
                      textOn: 'On',
                      textOff: 'Off',
                      colorOn: Color.fromRGBO(20, 202, 136, 1),
                      colorOff: Color.fromRGBO(0, 0, 0, 0.25),
                      iconOn: Icons.nights_stay_outlined,
                      iconOff: Icons.wb_sunny_outlined,
                      textSize: 18.0,
                      onChanged: (state) {
                        final provider =
                            Provider.of<ThemeProvider>(context, listen: false);
                        provider.toggleTheme(state);
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _toggleButton();
                    },
                    icon: _historyOpened
                        ? Icon(
                            Icons.access_time,
                            color: Color.fromRGBO(20, 202, 136, 1),
                          )
                        : Icon(
                            Icons.access_time,
                          ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _expression,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 48, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      margin: EdgeInsets.only(top: 20, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(_result,
                              style: Theme.of(context).textTheme.bodyText1),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: getFullHeight(context) * .50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildButtonExpression("C"),
                              buildButtonExpression("%"),
                              buildButtonExpression("⌫"),
                              buildButtonExpression("÷"),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildButtonNumber("7"),
                              buildButtonNumber("8"),
                              buildButtonNumber("9"),
                              buildButtonExpression("×"),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildButtonNumber("4"),
                              buildButtonNumber("5"),
                              buildButtonNumber("6"),
                              buildButtonExpression("-"),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildButtonNumber("1"),
                              buildButtonNumber("2"),
                              buildButtonNumber("3"),
                              buildButtonExpression("+"),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildButtonNumber("00"),
                              buildButtonNumber("0"),
                              buildButtonNumber(","),
                              Container(
                                height: 70,
                                width: 70,
                                // ignore: deprecated_member_use
                                child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    onPressed: () {
                                      buttonPressed("=");
                                    },
                                    color: Color.fromRGBO(20, 202, 136, 1),
                                    child: Text(
                                      "=",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                          fontSize: 24),
                                    )),
                              )
                            ]),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
