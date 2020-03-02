import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Cidadão',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Calculadora Cidadão'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _CamposCalculo {
  String meses = '';
  String taxaMensal = '';
  String capitalAtual = '';
  String valorFinal = '';
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  _CamposCalculo _valorCampo = new _CamposCalculo();

  //NumberFormat formatter = NumberFormat("00.00")

  TextEditingController _mesesController = new TextEditingController();
  TextEditingController _jurosController = new TextEditingController();
  TextEditingController _capitalController = new TextEditingController();
  TextEditingController _valorFinalController =
      new TextEditingController();

  void calculaValorFinal() {
    setState(() {
      double valorDepositoRegular = double.tryParse(_capitalController.text);
      //150;
      double valorJuros = double.tryParse(_jurosController.text) / 100;
      // 0.012;
      int qtdMeses = int.tryParse(_mesesController.text);
      //  8;

      double valorFinalObtido = double.tryParse(_capitalController.text);

      print(" ${valorDepositoRegular}");
      print(" ${valorJuros}");
      print(" ${qtdMeses}");

      valorFinalObtido = (valorDepositoRegular * (((pow(1 + valorJuros, qtdMeses + 1) - 1) / valorJuros) - 1));
      _valorFinalController.text = valorFinalObtido.toStringAsPrecision(3);
      print(" ${valorFinalObtido}");
      return _valorFinalController;
    });
  }

  void calculaDepositoRegular() {
    setState(() {
      double valorFinal = double.tryParse(_valorFinalController.text);
      double valorJuros = double.tryParse(_jurosController.text) / 100;
      int qtdMeses = int.tryParse(_mesesController.text);
      double valorDepositoRegular = double.tryParse(_capitalController.text);

      print(" ${valorFinal}");
      print(" ${valorJuros}");
      print(" ${qtdMeses}");

      // var taxaJuros = valorJuros / 100;
      valorDepositoRegular = (valorFinal / (((pow(1 + valorJuros, qtdMeses + 1) - 1) / valorJuros) - 1));
      _capitalController.text = valorDepositoRegular.toStringAsPrecision(4);
      print(" ${valorDepositoRegular}");
      return  _capitalController;
    });
  }

  void qualOCalculo(){
    setState(() {
      if(_mesesController.text != null  && _jurosController.value != null && _capitalController.text != null && _valorFinalController.text == null){
        calculaValorFinal();
        // ignore: unnecessary_statements

      }
     if(_mesesController.text != null && _jurosController.text != null && _valorFinalController.text != null){
        calculaDepositoRegular();
       // this._capitalController.text;
      }
    });
  }

//  void calculaQtdMes(double valorFinal, double valorDepositoRegular, double valorJuros){
//    setState(() {
//      var taxaJuros = valorJuros/100;
//      var qtdMeses = (valorFinal / ((pow(1 + taxaJuros, qtdMeses + 1) - 1) / taxaJuros));
//      return valorDepositoRegular;
//    }
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: Text(
              "Simule sua aplicação financeira",
              style: TextStyle(color: Colors.indigo, fontSize: 20),
            )),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      autofocus: true,
                      controller: _mesesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightGreenAccent, width: 3.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.lightGreen, width: 3.0),
                        ),
                        labelText: 'Número de meses',
//                      suffixIcon: IconButton(
//                        onPressed: () => _controller.clear(),
//                        icon: Icon(Icons.clear),
//                      )
                      ),
                      onSaved: (String value) {
                        this._mesesController = value as TextEditingController;
                      },
                    ),
                    Divider(),
                    TextFormField(
                      autofocus: true,
                      controller: _jurosController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightGreenAccent, width: 3.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.lightGreen, width: 3.0),
                        ),
                        labelText: 'Taxa de juros mensal (%) ',
                      ),
                      onSaved: (String value) {
                        this._jurosController = value as TextEditingController;
                      },
                    ),

                    Divider(),
                    TextFormField(
                      autofocus: true,
                      controller: _capitalController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightGreenAccent, width: 3.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.lightGreen, width: 3.0),
                        ),
                        labelText: 'Capital atual',
                      ),
                      onSaved: (String value) {
                        this._capitalController = value as TextEditingController;
                      },
                    ),
                    Divider(),
                    TextFormField(
                      autofocus: true,
                      controller: _valorFinalController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightGreenAccent, width: 3.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.lightGreen, width: 3.0),
                        ),
                        labelText: 'Valor obtido no final',
                      ),
                      onSaved: (String value) {
                        this._valorFinalController = value as TextEditingController;
                      },
                    ),
                    Divider(),
                    ButtonTheme(
                      height: 40.0,
                      child: RaisedButton(
                        onPressed: qualOCalculo,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        child: Text(
                          "Calcular",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        color: Colors.lightBlue,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _mesesController.clear();
                          _jurosController.clear();
                          _capitalController.clear();
                          _valorFinalController.clear();
                        }
                      },
                      child: Text(
                        'Limpar',
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


