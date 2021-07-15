import 'package:flutter/material.dart';
import 'NumberSlot.dart';
import 'package:provider/provider.dart';
import '../DataClass/LottoPanel.dart';

class SlotUnit extends StatefulWidget {
  SlotUnit({
    Key? key,
    required this.numDigits,
  }) : super(key: key);

  final int numDigits;

  @override
  _SlotUnitState createState() => _SlotUnitState();  
}

class _SlotUnitState extends State<SlotUnit> {
  var _numSlotsControl;
  var _focusNodes;
  var _numSlots;
  var _numDigits;

  @override
  void initState() {
    super.initState();
    _numDigits = widget.numDigits;
    _numSlotsControl = List.generate(_numDigits, (index) => TextEditingController());
    _focusNodes = List.generate(_numDigits, (index) => FocusNode());
    _numSlots = List<int>.filled(_numDigits, 0, growable: false);
  }

  void _onChangeSlot(int index) {
    setState(() {
      //print('Re-render()');
      _numSlots[index] = int.parse(_numSlotsControl[index].text);
      if (index < (_numDigits - 1)) {
        _focusNodes[index + 1].requestFocus(); //Fixed pls
        _numSlotsControl[index + 1].selection = TextSelection(baseOffset: 0, extentOffset: _numSlotsControl[index + 1].text.length);
      }
    });
  }

  void addSlot(){
    bool chkState = true;
    for (var fieldControl in _numSlotsControl) {
      if (fieldControl.text == ''){
        chkState = false;
      }
    }
    if (chkState){
      context.read<LottoPanel>().addSlot(_numSlots);
      for (var fieldControl in _numSlotsControl) {
        fieldControl.text = '';
        _focusNodes[0].requestFocus();
      }
    }
    else{
      print('Please fill number.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.indigoAccent,
        borderRadius: BorderRadius.all(
          Radius.circular(15)
        ),
        border: Border.all(
          width: 1
        )
      ),
      child: Row(
        children: [
          ...List<Widget>.generate(_numDigits, (index) {
            var paddingSet = EdgeInsets.only(right: 10);
            if (index == _numDigits - 1) {
              paddingSet = EdgeInsets.all(0);
            }
            return Padding(
              padding: paddingSet,
              child: NumSlot(
                slotId: index,
                textFieldControl: _numSlotsControl[index],
                numSlot: _numSlots[index],
                focusNode: _focusNodes[index],
                onChanged: _onChangeSlot
              ),
            );
          }).toList(),
          Padding(padding: EdgeInsets.only(right: 5)),
          ElevatedButton(
            onPressed: () => addSlot(),
            child: Icon(Icons.add),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(20),
              primary: Colors.grey[800],
              onPrimary: Colors.white,
            ),
          )
        ]
      ),
    );
  }
}
