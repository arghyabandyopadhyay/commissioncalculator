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
  double chemistsPrice = 0;
  double doctorsShare = 0;
  double doctorsPrice = 0;
  double mrp=0;
  double cp=0;
  double wscomm=0;
  double scheme=0;
  double margin=0;
  TextEditingController costPriceController=TextEditingController();
  TextEditingController mrpPriceController=TextEditingController();
  TextEditingController wholeSalersCommissionController=TextEditingController();
  TextEditingController chemistSchemeController=TextEditingController();
  void calculateValues(){
    mrp=(mrpPriceController.text!=""?double.parse(mrpPriceController.text):0);
    cp=(costPriceController.text!=""?double.parse(costPriceController.text):0);
    wscomm=(wholeSalersCommissionController.text!=""?double.parse(wholeSalersCommissionController.text)/100:0.2);
    scheme=((chemistSchemeController.text!=""?double.parse(chemistSchemeController.text):0)/100);
    margin=mrp-cp;
    wholeSalersShare=margin*wscomm;
    chemistsShare=margin*0.20;
    doctorsShare=margin*0.30;
    chemistsPrice=(mrp-chemistsShare)*(1-scheme);
    myShare=margin-wholeSalersShare-(chemistsShare+scheme*(mrp-chemistsShare))-doctorsShare;
    doctorsPrice=chemistsPrice-doctorsShare;
  }
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
                calculateValues();
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
                calculateValues();
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
                calculateValues();
              });
            },
          ),
          TextFormField(
            style: TextStyle(fontSize: 30),
            controller: chemistSchemeController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Chemist's Scheme (Percentage)",
            ),
            onChanged: (value)
            {
              setState(() {
                calculateValues();
              });
            },
          ),
          SizedBox(height: 10,),
          Text("Cost Price: ₹${cp.toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",),
          SizedBox(height: 10,),
          Text("MRP: ₹${mrp.toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",),
          SizedBox(height: 30,),
          Text("Wholesaler's Share: ₹${wholeSalersShare.toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",),
          SizedBox(height: 10,),
          Text("Wholesaler's Payment: ₹${(wholeSalersShare+cp).toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",),
          SizedBox(height: 30,),
          Text("My Share: ₹${myShare.toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",),
          SizedBox(height: 30,),
          Text("Chemist's Share: ₹${chemistsShare.toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",),
          SizedBox(height: 10,),
          Text("Chemist's Profit: ₹${(chemistsShare+scheme*(mrp-chemistsShare)).toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",),
          SizedBox(height: 10,),
          Text("Chemist's Price(exc GST): ₹${(chemistsPrice/1.18).toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",),
          SizedBox(height: 10,),
          Text("Chemist's Price(icl GST): ₹${(chemistsPrice).toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",),
          SizedBox(height: 30,),
          Text("Doctor's share(with chemist): ₹${doctorsShare.toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",),
          SizedBox(height: 10,),
          Text("Doctor's share(without chemist): ₹${(doctorsShare+chemistsShare).toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",),
          SizedBox(height: 10,),
          Text("Doctor's Price(exc GST): ₹${((doctorsPrice)/1.18).toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",),
          SizedBox(height: 10,),
          Text("Doctor's Price(icl GST): ₹${(doctorsPrice).toStringAsFixed(2).replaceAllMapped(commaRegex, (match) => matchFunc(match))}",),

        ],
      ),
    );
  }
}
