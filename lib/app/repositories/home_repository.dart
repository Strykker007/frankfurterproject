import 'dart:convert';

import 'package:frankfurterproject/app/constants/constants.dart';
import 'package:frankfurterproject/app/models/currencie_conversion_model.dart';
import 'package:frankfurterproject/app/models/currencies_model.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  Future<List<CurrenciesModel>> getCurrencies() async {
    try {
      List<CurrenciesModel> currencies = <CurrenciesModel>[];
      final result = await http.get(Uri.parse('https://$host/currencies'));
      Map<String, dynamic> response = json.decode(result.body);

      response.forEach((key, value) {
        currencies.add(CurrenciesModel.fromMap(key, value));
      });

      return currencies;
    } catch (e) {
      rethrow;
    }
  }

  Future<CurrencieConversionModel> getConvertedValue(
      String baseCurrencie, String baseFromConversion, String amount) async {
    try {
      CurrencieConversionModel conversionModel;
      final result = await http.get(Uri.parse(
          'https://$host/latest?amount=$amount&from=$baseCurrencie&to=$baseFromConversion'));
      Map<String, dynamic> response = json.decode(result.body);

      conversionModel =
          CurrencieConversionModel.fromMap(response, baseFromConversion);
      return conversionModel;
    } catch (e) {
      rethrow;
    }
  }
}
