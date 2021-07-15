import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'OptionItem.dart';

class ListInt {
  final List<int> listInt;

  ListInt({required this.listInt});
}

class LottoPanel with ChangeNotifier {
  List<ListInt> _slotLines = [];
  List<OptionItem> _optionItems = [];
  int _sumPrice = 0;

  List<ListInt> get getSlots {
    return this._slotLines;
  }

  List<OptionItem> get getOptionItems {
    return this._optionItems;
  }

  String get getSumPrice {
    return getTextFromInt(_sumPrice);
  }

  String get getSumPriceTwelve {
    return getTextFromInt(_sumPrice + (_sumPrice * 0.12).toInt());
  }

  void printSlot(List<int> slotline) {
    String temp = '';
    for (var item in slotline) {
      temp = temp + ' ' + item.toString();
    }
    print('Add slot success. => $temp');
  }

  void addSlot(List<int> slotline) {
    _slotLines.add(ListInt(listInt: slotline.toList()));
    priceCal();
    notifyListeners();
    printSlot(slotline);
  }

  void removeSlot(int index) {
    _slotLines.removeAt(index);
    priceCal();
    notifyListeners();
    //print('Remove slot success.');
  }

  void addOption(OptionItem optionItem) {
    _optionItems.add(optionItem);
    priceCal();
    notifyListeners();
    //print('Add option success.');
  }

  void removeOption(int index) {
    _optionItems.removeAt(index);
    notifyListeners();
    //print('Remove option success.');
  }

  void priceCal() {
    int facNumber;
    int facOption;
    int value;
    int valueTwelve;
    int price;
    _sumPrice = 0; //Clear sum price of previous round
    if (_optionItems.isNotEmpty && _slotLines.isNotEmpty) {
      for (var optionItem in _optionItems) {
        facOption = optionItem.getFactorOption;
        value = optionItem.getValue;
        //valueTwelve = optionItem.getValue + (optionItem.getValue * 0.12).toInt();
        optionItem.getPrice.clear(); //Clear old price of previous round
        optionItem.getPriceTwelve.clear(); //Clear old price of previous round
        //Check case of set is true
        if (optionItem.getOption[0]) {
          for (var slotItem in _slotLines) {
            facNumber = getFactorNumber(slotItem.listInt);
            price = facNumber * facOption * value;
            optionItem.addPrice(price);
            _sumPrice += price;
            price = ((price * 0.12) * 10).toInt();//facNumber * facOption * valueTwelve;
            optionItem.addPriceTwelve(price);
          }
        } else {
          price = _slotLines.length * facOption * value;
          optionItem.addPrice(price);
          _sumPrice += price;
          price = ((price * 0.12) * 10).toInt();//_slotLines.length * facOption * valueTwelve;
          optionItem.addPriceTwelve(price);
        }
      }
    }
  }

  //For 4 elements only
  int getFactorNumber(List<int> number) {
    int repaetCnt = 0;
    int multiFactor = 1;
    for (int i = 0; i < number.length; i++) {
      for (int j = i + 1; j < number.length; j++) {
        if (number[i] == number[j]) {
          repaetCnt++;
        }
      }
    }
    /* Example data
    1234	0
    1231	1
    1212	2
    1211	3
    1111	6 */
    switch (repaetCnt) {
      case 0:
        {
          multiFactor = 24;
          //print('No-repeat member');
        }
        break;
      case 1:
        {
          multiFactor = 12;
          //print('Repeat 2 positions.');
        }
        break;
      case 2:
        {
          multiFactor = 6;
          //print('Double repeat 2 positions.');
        }
        break;
      case 3:
        {
          multiFactor = 4;
          //print('Repeat 3 positions.');
        }
        break;
      case 6:
        {
          //print('Repeat 4 positions.');
        }
        break;
      default:
        break;
    }
    return multiFactor;
  }

  List<int> convertIntToListInt(int num) {
    int tempNum = num;
    String tempText = tempNum.toString();
    List<int> listOfInt = tempText.split('').map((e) => int.parse(e)).toList();
    return listOfInt;
  }

  String getTextFromListInt(List<int> number) {
    String text = '';
    if (number.isEmpty) {
      return text;
    }

    for (var item in number) {
      text = text + ' ' + item.toString();
    }
    return text;
  }

  String getTextFromInt(int number) {
    String text = '';
    List<int> listInt = convertIntToListInt(number);

    text = listInt[0].toString();
    int commaMillion = 100, commaThousand = 100; //Safety guard
    switch (listInt.length) {
      case 7:
        {
          commaMillion = 0;
          commaThousand = 3;
        }
        break;
      case 6:
        {
          commaThousand = 2;
        }
        break;
      case 5:
        {
          commaThousand = 1;
        }
        break;
      case 4:
        {
          commaThousand = 0;
        }
        break;
      default:
        break;
    }
    for (int i = 0; i < listInt.length - 1; i++) {
      if (i == commaMillion || i == commaThousand) {
        text = text + ' , ' + listInt[i + 1].toString();
      } else {
        text = text + ' ' + listInt[i + 1].toString();
      }
    }
    return text;
  }
}
