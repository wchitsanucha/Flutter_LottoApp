import 'package:flutter/material.dart';
import '../DataClass/OptionItem.dart';
import 'Button.dart';
import 'package:provider/provider.dart';
import '../DataClass/LottoPanel.dart';

typedef OptionCallback = void Function(OptionItem optionItem);
class OptionPanelSet extends StatefulWidget {

  OptionPanelSet({
    Key? key, 
  }) : super(key: key);

  final List<String> btnName = ['ชุด', 'ญ', 'ล', 'A1', 'B1', 'C1'];

  @override
  _OptionPanelSetState createState() => _OptionPanelSetState();
}

class _OptionPanelSetState extends State<OptionPanelSet> {
  late final TextEditingController valueFiedldControl;
  late final List<ButtonCreate> _btnPanel;
  late List<bool> _btnPanelStates;

  RegExp exp = RegExp(r"^[\d]{1,4}$");

  @override
  void initState(){
    super.initState();
    valueFiedldControl = TextEditingController();
    _btnPanelStates = List<bool>.filled(widget.btnName.length, false, growable: false);
    _btnPanel = widget.btnName.map(
      (btn) => ButtonCreate(
        btnName: btn, 
        btnCallback: (btnState) {_btnPanelStates[widget.btnName.indexOf(btn)] = btnState;}
      )
    ).toList();
  }

  void clearPanelState(){
    for (var member in _btnPanel){
      member.getState.clearState();
    }
    valueFiedldControl.text = "";
    //print('Clear success.');
  }

  void valueChk(){
    print('Button value before add into list.');
    for (var temp in _btnPanelStates){
      print('$temp');
    }
    print('${valueFiedldControl.text}');

    clearPanelState();
    print('--------------------------------------------');

    print('Button value after add into list.');
    for (var temp in _btnPanelStates){
      print('$temp');
    }
    print('${valueFiedldControl.text}');
    print('--------------------------------------------');
  }

  void addOption(){
    var value = valueFiedldControl.text;
    if (value.isNotEmpty && exp.hasMatch(value)) {
      context.read<LottoPanel>().addOption(
        OptionItem(
          itemType: 'typeA', 
          itemOption: _btnPanelStates.toList(), 
          itemValue: value
        )
      ); 
      //print('Create success.');
      clearPanelState();
    }
    else{
      print('Please fill number.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.all(
          Radius.circular(20)
        ),
        border: Border.all(
          width: 1
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ..._btnPanel,
          Container(
            width: 60,
            padding: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0)
              ),
              color: Colors.white,
              border: Border.all(
                width: 1
              )
            ),
            child: TextField(
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
              controller: valueFiedldControl,
              keyboardType: TextInputType.number,
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () => addOption(),
              child: Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                primary: Colors.grey[800],
                onPrimary: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}