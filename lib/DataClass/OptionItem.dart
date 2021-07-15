class OptionItem{
  OptionItem({
    required itemType, 
    required itemOption, 
    required itemValue    
  }) : 
    this._itemType = itemType,
    this._itemOption = itemOption,
    this._itemValue = itemValue;

  static const List<String> _btnName = ['ชุด', 'ญ', 'ล', 'A1', 'B1', 'C1'];
  final String _itemType;
  final List<bool> _itemOption;
  final String _itemValue;
  final List<int> _priceList = [];
  final List<int> _priceListTwelve = [];

  List<String> get getNameSet{
    return _btnName;
  }

  String get getType{
    return this._itemType;
  }

  List<bool> get getOption{
    return this._itemOption;
  }

  List<int> get getPrice{
    return this._priceList;
  }

  List<int> get getPriceTwelve{
    return this._priceListTwelve;
  }

  void addPrice(int price){
    _priceList.add(price);
  }

  void addPriceTwelve(int price){
    _priceListTwelve.add(price);
  }

  int get getFactorOption{
    int sum = 0;
    for (int i = 1; i < _itemOption.length; i++){
      sum += _itemOption[i] ? 1 : 0;
    }
    return sum;
  }

  int get getValue{
    return int.parse(this._itemValue);
  }
}