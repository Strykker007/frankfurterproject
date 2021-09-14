import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:frankfurterproject/app/models/currencie_conversion_model.dart';
import 'package:frankfurterproject/app/models/currencies_model.dart';
import 'package:frankfurterproject/app/modules/home/components/converted_currencie_card_widget.dart';
import 'package:frankfurterproject/app/modules/home/components/popup_menu_item_widget.dart';

import 'components/error_message_widget.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  TextEditingController _currencieToConvertController = TextEditingController();
  TextEditingController _currencieFromConvertController =
      TextEditingController();
  TextEditingController _amountCurrencieFromConvertController =
      TextEditingController();

  void getCurrencies() async {
    await store.getCurrencies();
  }

  @override
  void initState() {
    getCurrencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Frankfurter App'),
      ),
      body: Container(
        child: TripleBuilder<HomeStore, Exception, CurrencieConversionModel>(
          store: store,
          builder: (_, model) {
            if (store.isLoading && store.currencies.length <= 0) {
              return Center(child: CircularProgressIndicator());
            }
            if (store.error != null && store.currencies.length <= 0) {
              return ErrorMessageWidget();
            }
            return Center(
              child: Container(
                margin: EdgeInsets.all(30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                          'Selecione os tipos de moeda para realizar a conversão'),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text('Converter de:'),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: PopupMenuItemWidget(
                              controller: _currencieToConvertController,
                              onSelected: (CurrenciesModel value) {
                                _currencieToConvertController.text = value.key;
                                store.baseCurrencie = value.key;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text('para:'),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: PopupMenuItemWidget(
                              controller: _currencieFromConvertController,
                              onSelected: (CurrenciesModel value) {
                                _currencieFromConvertController.text =
                                    value.key;
                                store.baseFromConversion = value.key;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text('Quantidade:'),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: TextFormField(
                              validator: (message) {
                                if (_amountCurrencieFromConvertController
                                        .text.length <=
                                    0) {
                                  return 'Digite a quantidade que deseja converter';
                                }
                                return null;
                              },
                              controller: _amountCurrencieFromConvertController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              onSaved: (value) {
                                _amountCurrencieFromConvertController.text =
                                    value;
                                store.amount = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        color: Theme.of(context).cardColor,
                      ),
                      ConvertedCurrencieCardWidget(
                        model: store.state,
                        fromConvertCurrencie: store.baseFromConversion,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: TripleBuilder(
        builder: (_, model) {
          return model.isLoading == false || store.currencies.length > 0
              ? FloatingActionButton(
                  foregroundColor: Theme.of(context).textTheme.bodyText1.color,
                  onPressed: model.isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            await store
                                .convertCurrencie(store.baseCurrencie,
                                    store.baseFromConversion, store.amount)
                                .then((value) {
                              _amountCurrencieFromConvertController.clear();
                              _currencieFromConvertController.clear();
                              _currencieToConvertController.clear();
                            });
                          }
                        },
                  child: model.isLoading
                      ? CircularProgressIndicator(
                          color: Theme.of(context).backgroundColor,
                        )
                      : Icon(
                          Icons.monetization_on_outlined,
                          size: 50,
                        ),
                )
              : Container();
        },
      ),
    );
  }
}
