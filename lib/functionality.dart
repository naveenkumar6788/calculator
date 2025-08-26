import 'package:calculator/buttons.dart';
import "package:math_expressions/math_expressions.dart";
import 'package:flutter/material.dart';

class Functionality {
  static String myInput = "";
  static bool isDotUsed = false;
  static bool isoperatorused = false;
  static void appendInput(String s, Function setState) {
    setState(() {
      switch (s) {
        case String digit when Buttons.digitButtons.contains(s):
          myInput += digit;
          isoperatorused = false;
          break;
        case "AC":
          myInput = "";
          break;
        case "⌫":
          if (myInput.isNotEmpty) {
            myInput = myInput.substring(0, myInput.length - 1);
          }
          break;
        case ".":
          if (isDotUsed) {
            return;
          }
          if (myInput.isEmpty) {
            myInput += "0.";
            isDotUsed = true;
          } else {
            myInput += ".";
            isDotUsed = true;
          }
          break;

        case String op when Buttons.operatorButtons.contains(s):
          if (op == "=" && myInput.isNotEmpty && !islastvalueoperator(myInput)) {
            myInput = calculateresult(myInput);
          } else if (!isoperatorused && op != "=") {
            myInput += op;
            isoperatorused = true;
            isDotUsed = false;
          }
      }
    });
  }

  static String calculateresult(String expression) {
    ExpressionParser ep = GrammarParser();
    ContextModel contextModel = ContextModel();
    Expression exp = ep.parse(expression);

    double result = exp.evaluate(EvaluationType.REAL, contextModel);
    bool isInt = isInteger(result);
    if (isInt) {
      return result.toInt().toString();
    } else {
      return result.toStringAsFixed(2);
    }
  }

  static bool isInteger(double num) {
    if (num % 1 == 0) {
      return true;
    } else {
      return false;
    }
  }

  static bool islastvalueoperator(String s) {
    int n = s.length;
    return Buttons.operatorButtons.contains(s[n - 1]);
  }
}
