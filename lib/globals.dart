library globals;

import 'package:flutter/material.dart';

final allBoyNames = <String>[];
final allGirlNames = <String>[];
const font = TextStyle(fontSize: 20);
final saved = <Names>[];
bool boy = false;

class Names {
  String? Name;
  bool IsBoy = false;
  Names(String _Name, bool _IsBoy) {
    Name = _Name;
    IsBoy = _IsBoy;
  }
  @override
  bool operator ==(covariant Names name) =>
      Name == name.Name && IsBoy == name.IsBoy;
}
