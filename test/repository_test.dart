import 'package:flutter_test/flutter_test.dart';
import 'package:frankfurterproject/app/models/currencie_conversion_model.dart';
import 'package:frankfurterproject/app/models/currencies_model.dart';

import 'package:frankfurterproject/app/repositories/home_repository.dart';

void main() {
  group(
    'Teste de repositório',
    () {
      var repository = HomeRepository();

      test(
        'Deve retornar a instância de uma lista de CurrenciesModel',
        () {
          expect(repository.getCurrencies(),
              isInstanceOf<Future<List<CurrenciesModel>>>());
        },
      );
      test(
        'Deve retornar um resultado de conversão de moeda',
        () async {
          CurrencieConversionModel response =
              await repository.getConvertedValue('USD', 'BRL', '1');

          expect(response, isInstanceOf<CurrencieConversionModel>());
        },
      );
    },
  );
}
