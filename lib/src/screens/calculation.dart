const c_op = ['+', '-', '%', '￥', '×', '÷'];

class Calculator {
  static var _number = [];
  static var _op = [];

  static String _buffer = '';

  ///
  static var _parcent = [];

  ///

  static void GetKey(String letter) {
    // 四則演算子
    for (int i = 0; i < _op.length; i++) {
      if (c_op.contains(letter)) {
        _op.add(letter);
        _number.add(double.parse(_buffer));
        _buffer = '';
      } // C
      else if (letter == 'C') {
        _number.clear();
        _op.clear();
        _buffer = '';
      } // =
      ///
      else if (letter == '￥') {
        _parcent = _number[i + 1] / 100;
      } // ￥
      ///
      else if (letter == '=') {
        return null;
      } // 数字
      else {
        _buffer += letter;
      }
    }
  }

  static double _result = 0;
  static String Execute() {
    _number.add(double.parse(_buffer));
    if (_number.length == 0) return '0';
    _result = _number[0];
    for (int i = 0; i < _op.length; i++) {
      if (_op[i] == '+')
        _result += _number[i + 1];
      else if (_op[i] == '-')
        _result -= _number[i + 1];
      else if (_op[i] == '×')
        _result *= _number[i + 1];
      else if (_op[i] == '÷' && _number[i + 1] != 0)
        _result /= _number[i + 1];

      ///
      else if (_op[i] == '￥')
        _result += _number[i + 1] + _parcent;

      ///
      else
        return 'e';
    }

    _number.clear();
    _op.clear();
    _buffer = '';

    ///
    _parcent.clear();

    ///

    var resultStr = _result.toString().split('.');
    return resultStr[1] == '0' ? resultStr[0] : _result.toString();
  }
}

class parcent {}

// import 'dart:collection';

// var digits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
// var operators = ['+', '-', '*', '/'];

// class Parser {
//   const Parser();

//   num _eval(num op1, num op2, String op) {
//     switch (op) {
//       case '+':
//         return op1 + op2;
//       case '-':
//         return op1 - op2;
//       case '*':
//         return op1 * op2;
//       case '/':
//         return op1 / op2;
//       default:
//         return 0;
//     }
//   }

//   int _getPriority(String op) {
//     switch (op) {
//       case '+':
//       case '-':
//         return 0;
//       case '*':
//       case '/':
//         return 1;
//       default:
//         return -1;
//     }
//   }

//   bool _isOperator(String op) {
//     return operators.contains(op);
//   }

//   bool _isDigit(String op) {
//     return digits.contains(op);
//   }

//   num parseExpression(String expr) {
//     Queue operators = new ListQueue();
//     Queue operands = new ListQueue();

//     // True if the last character was a digit
//     // to accept numbers with more digits
//     bool lastDig = true;

//     // INIT
//     operands.addLast(0);

//     expr.split('').forEach((String c) {
//       if (_isDigit(c)) {
//         if (lastDig) {
//           num last = operands.removeLast();
//           operands.addLast(last * 10 + int.parse(c));
//         } else
//           operands.addLast(int.parse(c));
//       } else if (_isOperator(c)) {
//         if (!lastDig) throw new ArgumentError('Illegal expression');

//         if (operators.isEmpty)
//           operators.addLast(c);
//         else {
//           while (operators.isNotEmpty &&
//               operands.isNotEmpty &&
//               _getPriority(c) <= _getPriority(operators.last)) {
//             num op1 = operands.removeLast();
//             num op2 = operands.removeLast();
//             String op = operators.removeLast();

//             // op1 and op2 in reverse order!
//             num res = _eval(op2, op1, op);
//             operands.addLast(res);
//           }
//           operators.addLast(c);
//         }
//       }
//       lastDig = _isDigit(c);
//     });

//     while (operators.isNotEmpty) {
//       num op1 = operands.removeLast();
//       num op2 = operands.removeLast();
//       String op = operators.removeLast();

//       // op1 and op2 in reverse order!
//       num res = _eval(op2, op1, op);
//       operands.addLast(res);
//     }

//     return operands.removeLast();
//   }
// }
