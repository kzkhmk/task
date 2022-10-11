// const c_op = ['+', '-', '×', '÷'];
// const ops = ['￥'];
// const opt = ['π'];

// class Calculator {
//   static var _number = [];
//   static var _op = [];

//   static String _buffer = '';

//   static void GetKey(String letter) {
//     // 四則演算子
//     if (letter == '￥') {
//       return;
//     } else if (c_op.contains(letter)) {
//       _op.add(letter);
//       _number.add(double.parse(_buffer));
//       _buffer = '';
//     } // C
//     else if (letter == 'C') {
//       _number.clear();
//       _op.clear();
//       _buffer = '';
//     } else if (letter == '=') {
//       return null;
//     } // 数字
//     else {
//       _buffer += letter;
//     }
//   }

//   static double _result = 0;
//   static double opt = 3.14;
//   static String Execute(String s) {
//     _number.add(double.parse(_buffer));
//     if (_number.length == 0) return '0';
//     _result = _number[0];
//     for (int i = 0; i < _op.length; i++) {
//       if (_op[i] == '+')
//         _result += _number[i + 1];
//       else if (_op[i] == '-')
//         _result -= _number[i + 1];
//       else if (_op[i] == '×')
//         _result *= _number[i + 1];
//       else if (_op[i] == '÷' && _number[i + 1] != 0)
//         _result /= _number[i + 1];
//       else
//         return 'e';
//     }

//     if (_number.length == 0) return '0';
//     _result = _number[0];
//     for (int i = 0; i < _op.length; i++) {
//       if (ops == '￥') {
//         _result = _result / 100;
//       } else if (opt == 'π') {
//         _result *= _number[i + 1];
//       }
//     }

//     _number.clear();
//     _op.clear();
//     _buffer = '';

//     ///
//     // _parcent.clear();

//     ///

//     var resultStr = _result.toString().split('.');
//     return resultStr[1] == '0' ? resultStr[0] : _result.toString();
//   }
// }
