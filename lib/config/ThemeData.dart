import 'package:flutter/material.dart';

Color themeColor = fromHex('#F5BD1F');


  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
   Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
