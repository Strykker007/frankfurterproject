import 'package:flutter_triple/flutter_triple.dart';
import 'package:frankfurterproject/app/models/currencie_conversion_model.dart';
import 'package:frankfurterproject/app/models/currencies_model.dart';
import 'package:frankfurterproject/app/repositories/home_repository.dart';

// ignore: must_be_immutable
class HomeStore extends NotifierStore<Exception, CurrencieConversionModel> {
  HomeRepository repository = HomeRepository();
  List<CurrenciesModel> currencies = <CurrenciesModel>[];
  String baseCurrencie = '';
  String baseFromConversion = '';
  String amount = '';

  HomeStore() : super(null);

  Future<void> convertCurrencie(
      String baseCurrencie, String baseFromConversion, String amount) async {
    setLoading(true);
    await repository
        .getConvertedValue(baseCurrencie, baseFromConversion, amount)
        .then((result) {
      update(result);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(Exception(onError));
    });
    setLoading(false);
  }

  Future<void> getCurrencies() async {
    currencies = <CurrenciesModel>[];

    setLoading(true);

    await Future.delayed(Duration(seconds: 3));
    await repository.getCurrencies().then((value) {
      currencies = value;
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(Exception(onError));
    });
    setLoading(false);
  }
}
