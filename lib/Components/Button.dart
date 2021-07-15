import 'package:flutter/material.dart';

typedef ButtonCallback = void Function(bool btnState);
class ButtonCreate extends StatefulWidget {
  ButtonCreate({
    Key? key,
    required this.btnName,
    required this.btnCallback,
  }) : super(key: key);

  final String btnName;
  final ButtonCallback btnCallback;
  late final _ButtonCreateState _btnCreateState;

  _ButtonCreateState get getState{
    return _btnCreateState;
  }

  //_ButtonCreateState createState() => _ButtonCreateState();
  @override
  _ButtonCreateState createState() {
    _btnCreateState = _ButtonCreateState();
    return _btnCreateState;
  }
}

class _ButtonCreateState extends State<ButtonCreate> {

  late bool _btnState;

  @override
  void initState(){
    super.initState();
    this._btnState = false;
  }

  void clearState(){
    setState(() {
      _btnState = false;
      widget.btnCallback(getBtnState);
    });
  }

  bool get getBtnState{
    return _btnState;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _btnState = !_btnState;
          widget.btnCallback(getBtnState);
        });
        //print('State of button ${widget.btnName} is: $getBtnState');
      },
      child: Text(
        widget.btnName, 
        style: TextStyle(fontSize: 20)
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
        primary: _btnState ? Colors.grey[800] : Colors.white,
        onPrimary: _btnState ? Colors.white : Colors.black,
      ),
    );
  }
}