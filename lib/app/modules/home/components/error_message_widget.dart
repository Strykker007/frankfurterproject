import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:frankfurterproject/app/modules/home/home_store.dart';

class ErrorMessageWidget extends StatefulWidget {
  const ErrorMessageWidget({Key key}) : super(key: key);

  @override
  _ErrorMessageWidgetState createState() => _ErrorMessageWidgetState();
}

class _ErrorMessageWidgetState extends State<ErrorMessageWidget> {
  HomeStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          store.selectError.value.toString(),
                          textAlign: TextAlign.center,
                        ),
                        IconButton(
                          onPressed: () async {
                            await store.getCurrencies();
                          },
                          icon: Icon(Icons.replay_outlined),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
