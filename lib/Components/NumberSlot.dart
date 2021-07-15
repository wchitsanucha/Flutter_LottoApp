import 'package:flutter/material.dart';

class NumSlot extends StatefulWidget {
  const NumSlot({
    Key? key,
    required this.slotId,
    required this.textFieldControl,
    required this.numSlot,
    required this.focusNode,
    required this.onChanged
  }) : super(key: key);

  final int slotId;
  final TextEditingController textFieldControl;
  final int numSlot;
  final FocusNode focusNode;
  final ValueChanged<int> onChanged;

  @override
  _NumSlotState createState() => _NumSlotState();
}

class _NumSlotState extends State<NumSlot> {
  void _handleTextField(){
    widget.onChanged(widget.slotId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          padding: EdgeInsets.only(left: 6, right: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0)
            ),
            color: Colors.blue[50],
            border: Border.all(
              width: 1
            )
          ),
          child: TextField(
            style: TextStyle(
              fontSize: 20
            ),
            decoration: InputDecoration(
              counterText: "",
              counter: Offstage(),
            ),
            focusNode: widget.focusNode,
            textAlign: TextAlign.center,
            controller: widget.textFieldControl,
            maxLength: 1,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onChanged: (text) {_handleTextField();},
          )
        ),
        /* Padding(padding: EdgeInsets.all(2)),
        Text('${widget.numSlot}'), */
        //Padding(padding: EdgeInsets.all(5))
      ],
    );
  }
}