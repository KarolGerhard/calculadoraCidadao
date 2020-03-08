import 'dart:math';

import 'package:calculadoracidadaoapp/util/calculador.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Cidadão',
      debugShowCheckedModeBanner: false,
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


class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _mesesController = new TextEditingController();
  TextEditingController _jurosController = new TextEditingController();
  TextEditingController _capitalController = new TextEditingController();
  TextEditingController _valorFinalController = new TextEditingController();

  void _calcular() {
    var calculador = Calculador(
      meses: _mesesController.text,
      juros: _jurosController.text,
      capitalAtual: _capitalController.text,
      valorFinal: _valorFinalController.text,
    );

    try {
      var campoCalculo = calculador.campoCalculo();

      setState(() {
        if (campoCalculo == Campo.VALOR_FINAL) {
          _valorFinalController.text = calculador.calculaValorFinal();
        } else if (campoCalculo == Campo.CAPITAL) {
          _capitalController.text = calculador.calculaDepositoRegular();
        } else if (campoCalculo == Campo.MESES) {
          _mesesController.text = calculador.calculaPeriodo();
        } else {
          _jurosController.text = calculador.calculaJuros();
        }
      });
    }
    catch (e) {
      showAlertDialog(context, e.message);
    }
  }

  showAlertDialog(BuildContext context, String content) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Erro ao calcular"),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                  child: Text(
                    "Simule o valor futuro de um capital",
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
                            borderSide: BorderSide(
                                color: Colors.lightGreen, width: 3.0),
                          ),
                          labelText: 'Número de meses',
//                      suffixIcon: IconButton(
//                        onPressed: () => _controller.clear(),
//                        icon: Icon(Icons.clear),
//                      )
                        ),
                        onSaved: (String value) {
                          this._mesesController =
                          value as TextEditingController;
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
                            borderSide: BorderSide(
                                color: Colors.lightGreen, width: 3.0),
                          ),
                          labelText: 'Taxa de juros mensal (%) ',
                        ),
                        onSaved: (String value) {
                          this._jurosController =
                          value as TextEditingController;
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
                            borderSide: BorderSide(
                                color: Colors.lightGreen, width: 3.0),
                          ),
                          labelText: 'Capital atual',
                        ),
                        onSaved: (String value) {
                          this._capitalController =
                          value as TextEditingController;
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
                            borderSide: BorderSide(
                                color: Colors.lightGreen, width: 3.0),
                          ),
                          labelText: 'Valor obtido no final',
                        ),
                        onSaved: (String value) {
                          this._valorFinalController =
                          value as TextEditingController;
                        },
                      ),
                      Divider(),
                      ButtonTheme(
                        height: 40.0,
                        child: RaisedButton(
                          onPressed: _calcular,
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
      ),
    );
  }
}
