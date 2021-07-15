import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'OptionWidget.dart';
import 'SlotUnit.dart';
import 'OptionPanelSet.dart';
import '../DataClass/OptionItem.dart';
import '../DataClass/LottoPanel.dart';

class SlotArea extends StatefulWidget {
  const SlotArea({Key? key}) : super(key: key);

  @override
  _SlotAreaState createState() => _SlotAreaState();
}

class _SlotAreaState extends State<SlotArea> {
  late SlotUnit _slotUnits;

  @override
  void initState() {
    super.initState();
    _slotUnits = SlotUnit(numDigits: 4);
  }
 
  List<Widget> createOptionItems(List<OptionItem> opItems) {
    var objControl = context.read<LottoPanel>();
    return List<Widget>.generate(opItems.length, (index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onLongPress: () {
              objControl.removeOption(index);
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: OptionWidget(optionItem: opItems[index])
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      //color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ...opItems[index].getPrice.map((member) {
                            return Text(
                              objControl.getTextFromInt(member),
                              style: TextStyle(fontSize: 20)
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      //color: Colors.orangeAccent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ...opItems[index].getPriceTwelve.map((member) {
                            return Text(
                              objControl.getTextFromInt(member),
                              style: TextStyle(fontSize: 20, color: Colors.red)
                            );
                          })
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ),
          (index != (opItems.length - 1)) ? 
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Container(height: 2, width: MediaQuery.of(context).size.width * 0.72, color: Colors.brown),
          ) : Container()
        ],
      );      
    }).toList();
  }

  List<Widget> createSlotItems(List<ListInt> slotLines) {
    return List<Widget>.generate(slotLines.length, (index) {
      var objControl = context.read<LottoPanel>();
      return GestureDetector(
        onLongPress: () {
          print('Delete index => ${slotLines[index].listInt}');
          objControl.removeSlot(index);
        },
        child: Text(
          objControl.getTextFromListInt(slotLines[index].listInt), 
          style: TextStyle(fontSize: 20)
        )
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {

    var opItems = context.watch<LottoPanel>().getOptionItems;
    var slotItems = context.watch<LottoPanel>().getSlots;
    var objControl = context.watch<LottoPanel>();
    var widthSize = MediaQuery.of(context).size.width;

    final summaryWidget = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            flex: 3,
            child: Text('สรุปยอด =>', style: TextStyle(fontSize: 30, color: Colors.white))
          ),
          Flexible(
            flex: 2,
            child: Container(
              //color: Colors.indigo,
              alignment: Alignment.centerRight,
              child: Text(
                objControl.getSumPrice, 
                style: TextStyle(fontSize: 20)
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              //color: Colors.pink,
              alignment: Alignment.centerRight,
              child: Text(
                objControl.getSumPriceTwelve, 
                style: TextStyle(fontSize: 20, color: Colors.red)
              ),
            ),
          ),
        ],
      ),
    );

    return Column(
      children: [
        (slotItems.isNotEmpty || opItems.isNotEmpty) ?
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(widthSize * 0.02),    //Set size ratio here
          decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(width: 1)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                //color: Colors.purpleAccent,
                width: widthSize * 0.10,    //Set size ratio here
                child: Column(
                  children: <Widget>[
                    if (slotItems.isNotEmpty) ...createSlotItems(slotItems),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: widthSize * 0.02),
                  width: widthSize * 0.01,    //Set size ratio here
                  height: 30 * slotItems.length as double,
                  color: Colors.black,
              ),
              Container(
                //color: Colors.greenAccent,
                width: widthSize * 0.72,    //Set size ratio here
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (opItems.isNotEmpty) ...createOptionItems(opItems),
                    if (slotItems.isNotEmpty && opItems.isNotEmpty) Divider(height: 20, thickness: 3, color: Colors.red),
                    if (slotItems.isNotEmpty && opItems.isNotEmpty) summaryWidget,
                  ],
                ),
              )
            ],
          )
        ) : Text('Please fill data.', style: TextStyle(fontSize: 30)),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Container(
          //color: Colors.amber,
          width: widthSize,
          height: 140,
          alignment: Alignment.centerRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _slotUnits,
              OptionPanelSet()
            ],
          ),
        )
      ],
    );
  }
}
