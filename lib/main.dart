import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Components/SlotArea.dart';
import 'DataClass/LottoPanel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LottoPanel>(create: (_) => LottoPanel()),
      ],
      child: Lotto()
    )
  );
}

class Lotto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lotto_Cal_Prototype',
      theme: ThemeData(
        primaryColor: Colors.grey[900],
        accentColor: Colors.cyan[50],
      ),
      home: LottoHome(title: 'Lotto Cal'),
    );
  }
}

class LottoHome extends StatelessWidget {
  const LottoHome({ Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    var widthSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text(title)
        ),
      ),
      body: Container(
        width: widthSize,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey[400],
        padding: EdgeInsets.all(widthSize * 0.04),    //Set size ratio here
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('     4 หลัก', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Padding(padding: EdgeInsets.all(10)),
              SlotArea(),
              Divider(height: 50, thickness: 5, color: Colors.red)
            ],
          ),
        )
      )
    );
  }
}











