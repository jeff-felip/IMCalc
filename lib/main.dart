import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMCalc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'IMCalc'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ButtonStyle styleButton = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 18, fontFamily: "arial", fontWeight: FontWeight.bold),
  );
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String _info = "";
  Color colorIMC = Colors.black;
  String imagem = "";

  _calcIMC() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      print(imc);
      if (imc < 18.5) {
        imagem = "assets/images/peso1.png";
        colorIMC = Colors.blue;
        _info = 'IMC = ${imc.toStringAsPrecision(3)}\nSTATUS: Abaixo do Peso';
      } else if (imc >= 18.5 && imc < 25) {
        colorIMC = Colors.green;
        imagem = "assets/images/peso2.png";
        _info = 'IMC = ${imc.toStringAsPrecision(3)}\nSTATUS: Peso Normal';
      } else if (imc >= 25 && imc < 30) {
        imagem = "assets/images/peso3.png";
        colorIMC = Colors.yellow;
        _info = 'IMC = ${imc.toStringAsPrecision(3)}\nSTATUS: Sobrepeso';
      } else if (imc >= 30 && imc < 35) {
        imagem = "assets/images/peso4.png";
        colorIMC = Colors.amber;
        _info = 'IMC = ${imc.toStringAsPrecision(3)}\nSTATUS: Obesidade Grau I';
      } else if (imc >= 35 && imc < 40) {
        imagem = "assets/images/peso5.png";
        colorIMC = Colors.orange;
        _info = 'IMC = ${imc.toStringAsPrecision(3)}\nSTATUS: Obesidade Grau II';
      } else if (imc >= 40) {
        imagem = "assets/images/peso6.png";
        colorIMC = Colors.red;
        _info = 'IMC = ${imc.toStringAsPrecision(3)}\nSTATUS: Obesidade Mórbida';
      }
    });
  }

  Widget _resultIMC() {
    return Center(child: Text(_info, style: TextStyle(color: colorIMC, fontSize: 19, fontFamily: "arial", fontWeight: FontWeight.bold)));
  }

  Widget _imagemPeso() {
    if (pesoController.text.isEmpty) {
      return Container();
    }
    return Image.asset(imagem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Informe sua altura", style: TextStyle(fontSize: 16, fontFamily: "arial", fontWeight: FontWeight.bold)),
              TextField(
                controller: alturaController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Altura',
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 15),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    Text("Informe seu peso", style: TextStyle(fontSize: 16, fontFamily: "arial", fontWeight: FontWeight.bold)),
                    TextField(
                      controller: pesoController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Peso',
                      ),
                    )
                  ])),
              SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    style: styleButton,
                    onPressed: _calcIMC,
                    child: const Text('Calcular IMC'),
                  )),
              SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(margin: EdgeInsets.only(top: 20.0, right: 10), width: 50, height: 150, child: _imagemPeso()),
                      Container(margin: EdgeInsets.only(top: 20.0), width: 250, height: 150, child: _resultIMC()),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
