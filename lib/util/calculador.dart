import 'dart:math';
import 'package:intl/intl.dart';
import 'helper.dart';

enum Campo { MESES, JUROS, CAPITAL, VALOR_FINAL }

class Calculador {
  final String meses;
  final String juros;
  final String capitalAtual;
  final String valorFinal;

//  NumberFormat formatter = NumberFormat("##.##0,00", "PT");

  double _valorFinal;
  double _valorJuros;
  double _valorDepositoRegular;
  int _meses;

  Calculador({
    this.meses,
    this.juros,
    this.capitalAtual,
    this.valorFinal,
  }) {
    print('iniciado');

    _valorFinal = double.tryParse(this.valorFinal) ?? 0;
    _valorJuros = this.juros.isNotEmpty ? double.parse(this.juros) / 100 : 0;
    _valorDepositoRegular = double.tryParse(this.capitalAtual) ?? 0;
    _meses = this.meses.isNotEmpty ? int.parse(meses) : 0;

    print("ValorFinal: $_valorFinal");
    print("ValorJuros: $_valorJuros");
    print("ValorDepositoRegular: $_valorDepositoRegular");
    print("Meses: $_meses");
  }

  Campo campoCalculo() {
    if (isNotNullEmptyFalseOrZero(meses) &&
        isNotNullEmptyFalseOrZero(juros) &&
        isNotNullEmptyFalseOrZero(capitalAtual)) {
      return Campo.VALOR_FINAL;
    } else if (isNotNullEmptyFalseOrZero(meses) &&
        isNotNullEmptyFalseOrZero(juros) &&
        isNotNullEmptyFalseOrZero(valorFinal)) {
      return Campo.CAPITAL;
    } else if (isNotNullEmptyFalseOrZero(valorFinal) &&
        isNotNullEmptyFalseOrZero(juros) &&
        isNotNullEmptyFalseOrZero(capitalAtual)) {
      return Campo.MESES;
    } else if (isNotNullEmptyFalseOrZero(meses) &&
        isNotNullEmptyFalseOrZero(valorFinal) &&
        isNotNullEmptyFalseOrZero(capitalAtual)) {
      return Campo.JUROS;
    }

    throw Exception('Campo de cálculo não identificado, preencha pelo menos 3 campos para prosseguir!');
  }

  String calculaValorFinal() {
    double valorFinalObtido =
        _valorDepositoRegular * pow((1 + _valorJuros), _meses);
    print(valorFinalObtido);

    return (valorFinalObtido.toStringAsPrecision(3));
  }

  String calculaDepositoRegular() {
    double valorDepositoRegular;

    valorDepositoRegular = _valorFinal / (pow((1 + _valorJuros), _meses));
    print(valorDepositoRegular);
    return (valorDepositoRegular.toStringAsPrecision(4));
  }

  String calculaPeriodo() {
    int resultado =
        (log(_valorFinal / _valorDepositoRegular) / log(1 + _valorJuros))
            .ceil();
    print(resultado);
    return resultado.toString();
  }

  String calculaJuros() {
    var resultado =
    (pow((_valorFinal / _valorDepositoRegular), 1 / _meses) - 1) * 100;

    print('Juros: $resultado');
    return (resultado.toStringAsPrecision(4));
  }
}

