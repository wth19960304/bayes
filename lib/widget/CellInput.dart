import 'package:bayes/constant/color.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef InputCompleteCallback = Function(String content);

// ignore: must_be_immutable
class CellInput extends StatefulWidget {
  int cellCount = 4;
  InputType inputType = InputType.number;
  InputCompleteCallback? inputCompleteCallback;
  bool autofocus = true;
  Color solidColor;
  Color strokeColor;
  Color textColor;
  double fontSize;
  TextEditingController? controller;

  CellInput({
    required Key key,
    this.cellCount = 4,
    this.inputType = InputType.number,
    this.autofocus = true,
    this.inputCompleteCallback = _defaultCallback,
    this.solidColor = KColorConstant.white,
    this.strokeColor = Colors.transparent,
    this.textColor = Colors.black,
    this.fontSize = 27,
    this.controller,
  }) : super(key: key);

  // 默认的空回调函数
  static void _defaultCallback(String content) {}

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return _CellInputState(
      cellCount,
      inputType,
      autofocus,
      inputCompleteCallback ?? _defaultCallback,
      solidColor,
      strokeColor,
      textColor,
      fontSize,
      controller ?? TextEditingController(),
    );
  }
}

enum InputType { password, number, text }

class _CellInputState extends State<CellInput> {
  String inputStr = "";
  final int _cellCount;
  final InputType _inputType;
  final InputCompleteCallback _inputCompleteCallback;
  final bool _autofocus;
  final Color _solidColor;
  final Color _strokeColor;
  final Color _textColor;
  final double _fontSize;
  final TextEditingController _controller;

  _CellInputState(
    this._cellCount,
    this._inputType,
    this._autofocus,
    this._inputCompleteCallback,
    this._solidColor,
    this._strokeColor,
    this._textColor,
    this._fontSize,
    this._controller,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil.L(48),
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: getCells(),
          ),
          SizedBox(
            height: ScreenUtil.L(48),
            width: double.infinity,
            child: TextField(
              keyboardType: _keyboardType(),
              inputFormatters: [LengthLimitingTextInputFormatter(_cellCount)],
              decoration: InputDecoration(border: InputBorder.none),
              cursorWidth: 0,
              style: TextStyle(color: Colors.transparent),
              controller: _controller,
              autofocus: _autofocus,
              onChanged: (v) {
                setState(() {
                  inputStr = v;
                  if (v.length == _cellCount) {
                    _inputCompleteCallback(v);
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  String getIndexStr(int index) {
    if (inputStr.isEmpty) return "";
    if (inputStr.length > index) {
      if (_inputType == InputType.password) {
        return "●";
      } else {
        return inputStr[index];
      }
    } else {
      return "";
    }
  }

  TextInputType _keyboardType() {
    if (_inputType == InputType.number) {
      return TextInputType.number;
    } else if (_inputType == InputType.password) {
      return TextInputType.number;
    } else {
      return TextInputType.text;
    }
  }

  List<Widget> getCells() {
    var cells = <Widget>[];
    for (var i = 0; i < _cellCount; i++) {
      cells.add(
        Expanded(
          flex: 1,
          child: Center(
            child: Container(
              width: ScreenUtil.L(50),
              height: ScreenUtil.L(50),
              margin: EdgeInsets.only(left: 6, right: 6),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x30000000),
                    offset: Offset(0.0, 0.0),
                    blurRadius: 3.0 /*,spreadRadius:2.0*/,
                  ),
                ],
                color: _solidColor,
                border: Border.all(width: 1, color: getBoarderColor(i)),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                getIndexStr(i),
                style: TextStyle(
                  fontSize: _fontSize,
                  color: _textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return cells;
  }

  Color getBoarderColor(int index) {
    if (inputStr.isEmpty) {
      if (index == 0) {
        return _strokeColor;
      } else {
        return _solidColor;
      }
    } else {
      if (index == inputStr.length) {
        return _strokeColor;
      } else {
        return _solidColor;
      }
    }
  }
}
