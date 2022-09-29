import 'dart:async';

import 'package:flutter/material.dart';
import 'calculation.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ホーム'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            NumberField(),
            Keyboard(),
          ],
        )); //returnがついているものにだけ最後;をつける
  }
}

//表示
class NumberField extends StatefulWidget {
  _NumberFieldState createState() => _NumberFieldState();
}

class _NumberFieldState extends State<NumberField> {
  String _expression = "";

  void _UpdateNumber(String letter) {
    setState(() {
      if (letter == 'C')
        _expression = "";
      else if (letter == '=') {
        _expression = '';
        var ans = Calculator.Execute();
        controller.sink.add(ans);
      } else if (letter == 'e') {
        _expression = 'Error';
      } else
        _expression += letter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          _expression,
          style: TextStyle(
            fontSize: 64.0,
          ),
        ),
      ),
    );
  }

  static final controller = BehaviorSubject<String>();
  @override
  void initState() {
    controller.stream.listen((event) => _UpdateNumber(event));
    controller.stream.listen((event) => Calculator.GetKey(event));
  }
}

//キーボード
class Keyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 5,
        child: Center(
            child: Container(
          color: const Color(0xff87cefa),
          child: GridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 3.0,
            crossAxisSpacing: 3.0,
            children: [
              '%',
              'π',
              '￥',
              '',
              '7',
              '8',
              '9',
              '÷',
              '4',
              '5',
              '6',
              '×',
              '1',
              '2',
              '3',
              '-',
              'C',
              '0',
              '=',
              '+',
            ].map((key) {
              return GridTile(
                child: Button(key),
              );
            }).toList(),
          ),
        )));
  }
}

class Button extends StatelessWidget {
  final _key;
  Button(this._key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
      onPressed: () {
        _NumberFieldState.controller.sink.add(_key);
      },
      child: Center(
        child: Text(
          _key,
          style: TextStyle(fontSize: 46.0),
        ),
      ),
    ));
  }
}

// import 'package:flutter/material.dart';
// import 'calculation.dart';

// const appName = 'シンプル電卓';

// class CalculatorPage extends StatelessWidget {
//   const CalculatorPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: new Column(
//         children: [
//           new Display(),
//           new Keyboard(),
//         ],
//       ),
//     );
//   }
// }

// var _displayState = new DisplayState();

// class Display extends StatefulWidget {
//   @override
//   State createState() {
//     return _displayState;
//   }
// }

// class DisplayState extends State {
//   var _expression = '';
//   var _result = '';

//   @override
//   Widget build(BuildContext context) {
//     var views = [
//       new Expanded(
//           flex: 1,
//           child: new Row(
//             children: [
//               new Expanded(
//                   child: new Text(
//                 _expression,
//                 textAlign: TextAlign.right,
//                 style: new TextStyle(
//                   fontSize: 40.0,
//                   color: Colors.white,
//                 ),
//               ))
//             ],
//           )),
//     ];

//     if (_result.isNotEmpty) {
//       views.add(
//         new Expanded(
//             flex: 1,
//             child: new Row(
//               children: [
//                 new Expanded(
//                     child: new Text(
//                   _result,
//                   textAlign: TextAlign.right,
//                   style: new TextStyle(
//                     fontSize: 40.0,
//                     color: Colors.white,
//                   ),
//                 ))
//               ],
//             )),
//       );
//     }

//     return new Expanded(
//         flex: 2,
//         child: new Container(
//           color: Theme.of(context).primaryColor,
//           padding: const EdgeInsets.all(16.0),
//           child: new Column(
//             children: views,
//           ),
//         ));
//   }
// }

// void _addKey(String key) {
//   var _expr = _displayState._expression;
//   var _result = '';
//   if (_displayState._result.isNotEmpty) {
//     _expr = '';
//     _result = '';
//   }

//   if (operators.contains(key)) {
//     // Handle as an operator
//     if (_expr.length > 0 && operators.contains(_expr[_expr.length - 1])) {
//       _expr = _expr.substring(0, _expr.length - 1);
//     }
//     _expr += key;
//   } else if (digits.contains(key)) {
//     // Handle as an operand
//     _expr += key;
//   } else if (key == 'C') {
//     // Delete last character
//     if (_expr.length > 0) {
//       _expr = _expr.substring(0, _expr.length - 1);
//     }
//   } else if (key == '=') {
//     try {
//       var parser = const Parser();
//       _result = parser.parseExpression(_expr).toString();
//     } on Error {
//       _result = 'Error';
//     }
//   }
//   // ignore: invalid_use_of_protected_member
//   _displayState.setState(() {
//     _displayState._expression = _expr;
//     _displayState._result = _result;
//   });
// }

// class Keyboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Expanded(
//         flex: 4,
//         child: new Center(
//             child: new AspectRatio(
//           aspectRatio: 1.0, // To center the GridView
//           child: new GridView.count(
//             crossAxisCount: 4,
//             childAspectRatio: 1.0,
//             padding: const EdgeInsets.all(4.0),
//             mainAxisSpacing: 4.0,
//             crossAxisSpacing: 4.0,
//             children: [
//               // @formatter:off
//               '7', '8', '9', '/',
//               '4', '5', '6', '*',
//               '1', '2', '3', '-',
//               'C', '0', '=', '+',
//               // @formatter:on
//             ].map((key) {
//               return new GridTile(
//                 child: new KeyboardKey(key),
//               );
//             }).toList(),
//           ),
//         )));
//   }
// }

// class KeyboardKey extends StatelessWidget {
//   KeyboardKey(this._keyValue);

//   final _keyValue;

//   @override
//   Widget build(BuildContext context) {
//     return new ElevatedButton(
//       child: new Text(
//         _keyValue,
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 26.0,
//           color: Colors.black,
//         ),
//       ),
//       // Color: Theme.of(context).scaffoldBackgroundColor,
//       onPressed: () {
//         _addKey(_keyValue);
//       },
//     );
//   }
// }
