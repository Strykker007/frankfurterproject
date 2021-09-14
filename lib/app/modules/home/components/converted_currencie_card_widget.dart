import 'package:flutter/material.dart';
import 'package:frankfurterproject/app/models/currencie_conversion_model.dart';

class ConvertedCurrencieCardWidget extends StatefulWidget {
  final CurrencieConversionModel model;
  final String fromConvertCurrencie;
  const ConvertedCurrencieCardWidget(
      {Key key, this.model, this.fromConvertCurrencie})
      : super(key: key);
  @override
  _ConvertedCurrencieCardWidgetState createState() =>
      _ConvertedCurrencieCardWidgetState();
}

class _ConvertedCurrencieCardWidgetState
    extends State<ConvertedCurrencieCardWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.model != null
        ? Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).cardColor.withOpacity(0.2),
            ),
            height: MediaQuery.of(context).size.height * 0.18,
            width: MediaQuery.of(context).size.width - 0.1,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Converter de: ${widget.model.base}'),
                SizedBox(
                  height: 2,
                ),
                Text('Converter para: ${widget.fromConvertCurrencie}'),
                SizedBox(
                  height: 2,
                ),
                Text('Quantidade: ${widget.model.amount}'),
                SizedBox(
                  height: 2,
                ),
                Text('Data de referência: ${widget.model.referenceDate}'),
                SizedBox(
                  height: 2,
                ),
                Text('Resultado: ${widget.model.currencieConvertedValue}'),
              ],
            ),
          )
        : Container();
  }
}
