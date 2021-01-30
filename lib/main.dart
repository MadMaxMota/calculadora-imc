import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Informe os valores";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }
  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text)/100;
      double imc = weight/(height*height);
      print(imc);

      if(imc<16.5){
        _infoText = "Peso severamente baixo ${imc.toStringAsPrecision(2)}";
      }else if(imc>=16.5 && imc<18.5){
        _infoText = "Peso abaixo do normal ${imc.toStringAsPrecision(2)}";
      }else if(imc>=18.5 && imc<25){
        _infoText = "Normal  ${imc.toStringAsPrecision(2)}";
      }else if(imc>=25 && imc<30){
        _infoText = "Pré-Obeso  ${imc.toStringAsPrecision(2)}";
      }else if(imc>=30 && imc<35){
        _infoText = "Obesidade classe I ${imc.toStringAsPrecision(2)}";
      }else if(imc>=35 && imc<40){
        _infoText = "Obesidade classe II ${imc.toStringAsPrecision(2)}";
      }else if(imc>=40){
        _infoText = "Obesidade classe III ${imc.toStringAsPrecision(2)}";
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("IMC"),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ]
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.account_circle,
                    color: Colors.greenAccent,
                    size: 100,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: weightController,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                          ),

                          decoration: InputDecoration(
                              labelText: "Peso (Kg)",
                              labelStyle: TextStyle(color: Colors.greenAccent),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.greenAccent),
                                  borderRadius: BorderRadius.all(Radius.circular(20)))),

                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Informe seu peso";
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: heightController,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                          ),
                          decoration: InputDecoration(
                              labelText: "Altura (cm)",
                              labelStyle: TextStyle(color: Colors.greenAccent),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.greenAccent),
                                  borderRadius: BorderRadius.all(Radius.circular(20)))),

                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Informe sua altura";
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 1000,
                          child: RaisedButton(
                            child: Text(
                              "Calcular",
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            color: Colors.greenAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            onPressed: (){
                              if(_formKey.currentState.validate()){
                                _calculate();
                              }
                            },
                          ),
                        ),
                        Text(
                          "$_infoText",
                          style: TextStyle(fontSize: 30, color: Colors.greenAccent),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      );

  }
}


