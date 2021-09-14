import 'dart:convert';

class CurrencieConversionModel {
  double currencieConvertedValue;
  double amount;
  String base;
  String referenceDate;
  CurrencieConversionModel({
    this.currencieConvertedValue,
    this.amount,
    this.base,
    this.referenceDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'currencieConvertedValue': currencieConvertedValue,
      'amount': amount,
      'base': base,
      'referenceDate': referenceDate,
    };
  }

  factory CurrencieConversionModel.fromMap(
      Map<String, dynamic> map, String currencieBaseConverted) {
    return CurrencieConversionModel(
      currencieConvertedValue: map['rates'][currencieBaseConverted],
      amount: map['amount'],
      base: map['base'],
      referenceDate: map['date'],
    );
  }

  String toJson() => json.encode(toMap());
}
