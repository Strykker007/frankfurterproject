import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:frankfurterproject/app/models/currencies_model.dart';
import 'package:frankfurterproject/app/modules/home/home_store.dart';

class PopupMenuItemWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function onSelected;
  const PopupMenuItemWidget({
    Key key,
    @required this.controller,
    @required this.onSelected,
  }) : super(key: key);

  @override
  _PopupMenuItemWidgetState createState() => _PopupMenuItemWidgetState();
}

class _PopupMenuItemWidgetState extends State<PopupMenuItemWidget> {
  HomeStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: widget.controller,
      validator: (message) {
        if (widget.controller.text.length <= 0) {
          return 'Selecione uma opção!';
        }
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: PopupMenuButton<CurrenciesModel>(
          color: Theme.of(context).backgroundColor,
          icon: const Icon(Icons.arrow_drop_down),
          onSelected: widget.onSelected,
          itemBuilder: (BuildContext context) {
            return store.currencies
                .map<PopupMenuItem<CurrenciesModel>>((CurrenciesModel value) {
              return new PopupMenuItem(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: new Text(value.key + ': ' + value.currencieName),
                  value: value);
            }).toList();
          },
        ),
      ),
    );
  }
}
