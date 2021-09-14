import 'dart:convert';

class CurrenciesModel {
  String key;
  String currencieName;
  CurrenciesModel({
    this.key,
    this.currencieName,
  });

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'currencieName': currencieName,
    };
  }

  factory CurrenciesModel.fromMap(String key, String value) {
    return CurrenciesModel(
      key: key,
      currencieName: value,
    );
  }

  String toJson() => json.encode(toMap());
}
