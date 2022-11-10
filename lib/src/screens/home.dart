import 'package:flutter/material.dart';
import 'dart:math' as Math;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CaluculationPage(title: 'calc app'));
  }
}

class CaluculationPage extends StatefulWidget {
  const CaluculationPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CaluculationPage createState() => _CaluculationPage();
}

enum CALC_TYPE { add, sub, multi, div, clear, percent, pi, Square }

class _CaluculationPage extends State<CaluculationPage> {
  double _setNumber = 0; //計算用　初期値
  double _disNumber = 0; //表示用　初期値
  double _firstNum = 0; //最初に入れた数値　初期値
  double _persentNumber = 0;
  late CALC_TYPE _calcType;
  int _displayPow = 0;
  bool _decimalFlg = false;

  void _setNum(double num) {
    _displayPow = 0;
    if (_disNumber == _setNumber) {
      if (10000000000 > _disNumber) {
        setState(() {
          if (!_decimalFlg)
            _disNumber = _disNumber * 10 + num;
          else {
            int count = 1;
            for (int i = 0;
                _disNumber * Math.pow(10, i) !=
                    (_disNumber * Math.pow(10, i)).ceil();
                i++) {
              count++;
            }
            _disNumber = double.parse((_disNumber + (num / Math.pow(10, count)))
                .toStringAsFixed(count));
            _checkDecimal();
          }
          _setNumber = _disNumber;
        });
      }
    } else {
      setState(() {
        _disNumber = num;
        _setNumber = _disNumber;
        _calcType = null as CALC_TYPE;
      });
    }
  }

//ボタン初期値
  void _calcBtmPressed(CALC_TYPE type) {
    _setNumber = _disNumber;
    _firstNum = _setNumber;
    _setNumber = 0;
    _disNumber = 0;
    _calcType = type;
  }

//calcにnullを戻す
  void _calcClear() {
    setState(() {
      _calcType = null as CALC_TYPE;
    });
  }

//足し算
  void _calcAdd() {
    setState(() {
      _disNumber = _firstNum + _setNumber;
      _checkDecimal();
      _firstNum = _disNumber;
    });
  }

//引き算
  void _calcSub() {
    setState(() {
      _disNumber = _firstNum - _setNumber;
      _checkDecimal();
      _firstNum = _disNumber;
    });
  }

//掛け算
  void _calcMulti() {
    setState(() {
      _disNumber = _firstNum * _setNumber;
      _checkDecimal();
      _firstNum = _disNumber;
    });
  }

//割り算
  void _calcDiv() {
    setState(() {
      _disNumber = _firstNum / _setNumber;
      _checkDecimal();
      _firstNum = _disNumber;
    });
  }

//税込（１０％）計算
  void _calcPercent() {
    setState(() {
      _persentNumber = _firstNum / 10;
      _disNumber = _firstNum + _persentNumber;
      _checkDecimal();
      _firstNum = _disNumber;
    });
  }

//円周率計算
  void _PiNumber() {
    setState(() {
      _disNumber = _firstNum * Math.pi;
      _checkDecimal();
      _firstNum = _disNumber;
    });
  }

//倍数計算
  void _SquareNumber() {
    setState(() {
      _disNumber = _firstNum * _firstNum;
      _checkDecimal();
      _firstNum = _disNumber;
    });
  }

//マイナス表記
  void _invertedNum() {
    setState(() {
      _disNumber = -_disNumber;
      _setNumber = -_setNumber;
    });
  }

//小数点の処理
  void _checkDecimal() {
    double checkNum = _disNumber;
    if (100000000000 < _disNumber || _disNumber == _disNumber.toInt()) {
      for (int i = 0; 100000000000 < _disNumber / Math.pow(10, i); i++) {
        _displayPow = i;
        checkNum = checkNum / 10;
      }
      _disNumber = checkNum.floor().toDouble();
    } else {
      int count = 0;
      for (int i = 0; 1 < _disNumber / Math.pow(10, i); i++) {
        count = i;
      }
      int displayCount = 10 - count;
      _disNumber = double.parse(_disNumber.toStringAsFixed(displayCount));
    }
  }

//Cを押した時の処理
  void _clearNum() {
    setState(() {
      _setNumber = 0;
      _disNumber = 0;
      _firstNum = 0;
      _calcType = CALC_TYPE.clear;
      _displayPow = 0;
      _decimalFlg = false;
    });
  }

  void _clearEntryNum() {
    setState(() {
      _setNumber = 0;
      _disNumber = 0;
      _displayPow = 0;
      _decimalFlg = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return constraints.maxWidth < constraints.maxHeight
            ? _NormalWidget(context, false)
            : _NormalWidget(context, true);
      }),
    );
  }

  Widget _numWidget(BuildContext context, double num) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            _setNum(num);
          },
          child: Text(
            num.toInt().toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
            ),
          ),
        ),
      ),
    );
  }

  Widget _calcTypeWidget(
      BuildContext context, String text, CALC_TYPE calcType) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            _calcBtmPressed(calcType);
          },
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
            ),
          ),
        ),
      ),
    );
  }

  Widget _NormalWidget(BuildContext context, bool wide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          height: 20,
          child: _displayPow > 0
              ? Text(
                  "10^${_displayPow.toString()}",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              : Container(),
        ),
        Text(
          _disNumber == _disNumber.toInt()
              ? _disNumber.toInt().toString()
              : _disNumber.toString(),
          style: TextStyle(
            fontSize: 60,
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    if (wide == true)
                      _calcTypeWidget(context, "π", CALC_TYPE.pi),
                    _calcTypeWidget(context, "￥", CALC_TYPE.percent),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _clearEntryNum();
                          },
                          child: Text(
                            "CE",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _clearNum();
                            _calcBtmPressed(CALC_TYPE.clear);
                          },
                          child: Text(
                            "C",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                    _calcTypeWidget(context, "÷", CALC_TYPE.div),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    if (wide == true)
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _SquareNumber();
                            },
                            child: Text(
                              "x2",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    _numWidget(context, 7),
                    _numWidget(context, 8),
                    _numWidget(context, 9),
                    _calcTypeWidget(context, "×", CALC_TYPE.multi),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    _numWidget(context, 4),
                    _numWidget(context, 5),
                    _numWidget(context, 6),
                    _calcTypeWidget(context, "-", CALC_TYPE.sub),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    _numWidget(context, 1),
                    _numWidget(context, 2),
                    _numWidget(context, 3),
                    _calcTypeWidget(context, "+", CALC_TYPE.add),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _invertedNum();
                          },
                          child: Text(
                            "+/-",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                    _numWidget(context, 0),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _decimalFlg = true;
                          },
                          child: Text(
                            ".",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            switch (_calcType) {
                              case CALC_TYPE.add:
                                _calcAdd();
                                break;
                              case CALC_TYPE.sub:
                                _calcSub();
                                break;
                              case CALC_TYPE.multi:
                                _calcMulti();
                                break;
                              case CALC_TYPE.div:
                                _calcDiv();
                                break;
                              case CALC_TYPE.clear:
                                _calcClear();
                                break;
                              case CALC_TYPE.percent:
                                _calcPercent();
                                break;
                              case CALC_TYPE.pi:
                                _PiNumber();
                                break;
                              default:
                                break;
                            }
                          },
                          child: Text(
                            "=",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//   Widget _WideWidget(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: <Widget>[
//         Container(
//           height: 20,
//           child: _displayPow > 0
//               ? Text(
//                   "10^${_displayPow.toString()}",
//                   style: TextStyle(
//                     fontSize: 20,
//                   ),
//                 )
//               : Container(),
//         ),
//         Text(
//           _disNumber == _disNumber.toInt()
//               ? _disNumber.toInt().toString()
//               : _disNumber.toString(),
//           style: TextStyle(
//             fontSize: 60,
//           ),
//         ),
//         Expanded(
//           child: Column(
//             children: <Widget>[
//               Expanded(
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _calcBtmPressed(CALC_TYPE.pi);
//                           },
//                           child: Text(
//                             "π",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _calcBtmPressed(CALC_TYPE.percent);
//                           },
//                           child: Text(
//                             "￥",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _clearEntryNum();
//                           },
//                           child: Text(
//                             "CE",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _clearNum();
//                             _calcBtmPressed(CALC_TYPE.clear);
//                           },
//                           child: Text(
//                             "C",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _calcBtmPressed(CALC_TYPE.div);
//                           },
//                           child: Text(
//                             "÷",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _SquareNumber();
//                           },
//                           child: Text(
//                             "x2",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _setNum(7);
//                           },
//                           child: Text(
//                             "7",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _setNum(8);
//                           },
//                           child: Text(
//                             "8",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _setNum(9);
//                           },
//                           child: Text(
//                             "9",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _calcBtmPressed(CALC_TYPE.multi);
//                           },
//                           child: Text(
//                             "×",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _setNum(4);
//                           },
//                           child: Text(
//                             "4",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _setNum(5);
//                           },
//                           child: Text(
//                             "5",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _setNum(6);
//                           },
//                           child: Text(
//                             "6",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _calcBtmPressed(CALC_TYPE.sub);
//                           },
//                           child: Text(
//                             "-",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _setNum(1);
//                           },
//                           child: Text(
//                             "1",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _setNum(2);
//                           },
//                           child: Text(
//                             "2",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _setNum(3);
//                           },
//                           child: Text(
//                             "3",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _calcBtmPressed(CALC_TYPE.add);
//                           },
//                           child: Text(
//                             "+",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _invertedNum();
//                           },
//                           child: Text(
//                             "+/-",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _setNum(0);
//                           },
//                           child: Text(
//                             "0",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _decimalFlg = true;
//                           },
//                           child: Text(
//                             ".",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             switch (_calcType) {
//                               case CALC_TYPE.add:
//                                 _calcAdd();
//                                 break;
//                               case CALC_TYPE.sub:
//                                 _calcSub();
//                                 break;
//                               case CALC_TYPE.multi:
//                                 _calcMulti();
//                                 break;
//                               case CALC_TYPE.div:
//                                 _calcDiv();
//                                 break;
//                               case CALC_TYPE.clear:
//                                 _calcClear();
//                                 break;
//                               case CALC_TYPE.percent:
//                                 _calcPercent();
//                                 break;
//                               case CALC_TYPE.pi:
//                                 _PiNumber();
//                                 break;
//                               case CALC_TYPE.Square:
//                                 _SquareNumber();
//                                 break;
//                               default:
//                                 break;
//                             }
//                           },
//                           child: Text(
//                             "=",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// //表示
// class NumberField extends StatefulWidget {
//   _NumberFieldState createState() => _NumberFieldState();
// }

// class _NumberFieldState extends State<NumberField> {
//   String _expression = "";

//   void _UpdateNumber(String letter) {
//     setState(() {
//       if (letter == 'C')
//         _expression = "";
//       else if (letter == '=') {
//         _expression = '';
//         var ans = Calculator.Execute('=');
//         controller.sink.add(ans);
//       } else if (letter == '￥') {
//         _expression = '';
//         var ans = Calculator.Execute('￥');
//         controller.sink.add(ans);
//       } else if (letter == 'π') {
//         _expression = '';
//         var ans = Calculator.Execute('π');
//         controller.sink.add(ans);
//       } else if (letter == 'e') {
//         _expression = 'Error';
//       } else
//         _expression += letter;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: 1,
//       child: Align(
//         alignment: Alignment.center,
//         child: Text(
//           _expression,
//           style: TextStyle(
//             fontSize: 64.0,
//           ),
//         ),
//       ),
//     );
//   }

//   static final controller = BehaviorSubject<String>();
//   @override
//   void initState() {
//     controller.stream.listen((event) => _UpdateNumber(event));
//     controller.stream.listen((event) => Calculator.GetKey(event));
//   }
// }

// //キーボード
// class Keyboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//         flex: 5,
//         child: Center(
//             child: Container(
//           color: const Color(0xff87cefa),
//           child: GridView.count(
//             crossAxisCount: 4,
//             mainAxisSpacing: 3.0,
//             crossAxisSpacing: 3.0,
//             children: [
//               '%',
//               'π',
//               '￥',
//               '',
//               '7',
//               '8',
//               '9',
//               '÷',
//               '4',
//               '5',
//               '6',
//               '×',
//               '1',
//               '2',
//               '3',
//               '-',
//               'C',
//               '0',
//               '=',
//               '+',
//             ].map((key) {
//               return GridTile(
//                 child: Button(key),
//               );
//             }).toList(),
//           ),
//         )));
//   }
// }

// class Button extends StatelessWidget {
//   final _key;
//   Button(this._key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: ElevatedButton(
//       onPressed: () {
//         _NumberFieldState.controller.sink.add(_key);
//       },
//       child: Center(
//         child: Text(
//           _key,
//           style: TextStyle(fontSize: 46.0),
//         ),
//       ),
//     ));
//   }
// }
