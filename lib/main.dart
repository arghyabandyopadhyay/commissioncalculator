import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
RegExp commaRegex = new RegExp(r'(\d{1,2})(?=((\d{2})+\d{1})(?!\d))');
Function matchFunc = (Match match) => '${match[1]},';
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Commission Calculator',
      themeMode: ThemeMode.system,
      home: MyHomePage(title: 'Commission Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double wholeSalersShare = 0;
  double myShare = 0;
  double chemistsShare = 0;
  double doctorsShare = 0;
  TextEditingController costPriceController=TextEditingController();
  TextEditingController mrpPriceController=TextEditingController();
  TextEditingController wholeSalersCommissionController=TextEditingController();
  @override
  void initState() {
    super.initState();
    wholeSalersCommissionController.text="20";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: ListView(
        children: <Widget>[
          TextFormField(
            controller: costPriceController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Cost Price",
            ),
            style: TextStyle(fontSize: 30),
            onChanged: (value){
              setState(() {
                double temp=(mrpPriceController.text!=""?double.parse(mrpPriceController.text):0)-(value!=""?double.parse(value):0);
                wholeSalersShare=temp*0.20;
                chemistsShare=temp*0.20;
                doctorsShare=temp*0.30;
                myShare=temp-wholeSalersShare-chemistsShare-doctorsShare;
              });
            },
          ),
          TextFormField(
            style: TextStyle(fontSize: 30),
            controller: mrpPriceController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "MRP",
            ),
            onChanged: (value)
            {
              setState(() {
                double temp=(value!=""?double.parse(value):0)-(costPriceController.text!=""?double.parse(costPriceController.text):0);
                wholeSalersShare=temp*0.20;
                chemistsShare=temp*0.20;
                doctorsShare=temp*0.30;
                myShare=temp-wholeSalersShare-chemistsShare-doctorsShare;
              });
            },
          ),
          TextFormField(
            style: TextStyle(fontSize: 30),
            controller: wholeSalersCommissionController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Wholesaler's Commission (Percentage)",
            ),
            onChanged: (value)
            {
              setState(() {
                double temp=(mrpPriceController.text!=""?double.parse(mrpPriceController.text):0)-(costPriceController.text!=""?double.parse(costPriceController.text):0);
                wholeSalersShare=temp*(value!=""?double.parse(value)/100:0.2);
                chemistsShare=temp*0.20;
                doctorsShare=temp*0.30;
                myShare=temp-wholeSalersShare-chemistsShare-doctorsShare;
              });
            },
          ),
          SizedBox(height: 10,),
          Text("Cost Price: ₹${(costPriceController.text!=""?double.parse(costPriceController.text):0).toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",style: TextStyle(fontSize: 30),),
          SizedBox(height: 10,),
          Text("MRP: ₹${(mrpPriceController.text!=""?double.parse(mrpPriceController.text):0).toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",style: TextStyle(fontSize: 30),),
          SizedBox(height: 30,),
          Text("Wholesaler's Share: ₹${wholeSalersShare.toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",style: TextStyle(fontSize: 30),),
          SizedBox(height: 10,),
          Text("Wholesaler's Payment: ₹${(wholeSalersShare+(costPriceController.text!=""?double.parse(costPriceController.text):0)).toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",style: TextStyle(fontSize: 30),),
          SizedBox(height: 30,),
          Text("My Share: ₹${myShare.toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",style: TextStyle(fontSize: 30),),
          SizedBox(height: 30,),
          Text("Chemist's Share: ₹${chemistsShare.toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",style: TextStyle(fontSize: 30),),
          SizedBox(height: 10,),
          Text("Chemist's Price: ₹${((mrpPriceController.text!=""?double.parse(mrpPriceController.text):0)-chemistsShare).toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",style: TextStyle(fontSize: 30),),
          SizedBox(height: 30,),
          Text("Doctor's share: ₹${doctorsShare.toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",style: TextStyle(fontSize: 30),),
          SizedBox(height: 10,),
          Text("Doctor's Price: ₹${((mrpPriceController.text!=""?double.parse(mrpPriceController.text):0)-chemistsShare-doctorsShare).toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",style: TextStyle(fontSize: 30),),

        ],
      ),
    );
  }
}
