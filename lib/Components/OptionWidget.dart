import 'package:flutter/material.dart';
import '../DataClass/OptionItem.dart';

class OptionWidget extends StatelessWidget {
  OptionWidget({ 
    Key? key, 
    required this.optionItem
  }) : super(key: key);
  
  final OptionItem optionItem;

  final _fontStyle = TextStyle(fontSize: 20);

  Widget createContainer(Text tempText){    
    return Container(
      alignment: Alignment.center,
      child: tempText,
    );    
  }

  @override
  Widget build(BuildContext context) {
    return createOptionItem(optionItem.getOption);
  }
  
  Widget createOptionItem(List<bool> items){
    List<Widget> activeOptions = [];
    var optionName = optionItem.getNameSet;
    for (var i = 0; i < items.length; i++){
      if (items[i]){
        activeOptions.add(
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: createContainer(Text(optionName[i], style: _fontStyle)),
          )
        );
      }
    }
    activeOptions.add(createContainer(Text(optionItem.getValue.toString(), style: _fontStyle)));

    return Row(
      children: [
        ...activeOptions,
      ]
    );
  }

}