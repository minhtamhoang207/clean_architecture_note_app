import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';

class StringUtils {
  static String formatVNDCurrency(int value) {
    final format = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return format.format(value);
  }

  static File? base64ToFile(String? base64Image) {
    if (base64Image != null) {
      List<int> imageBytes = base64Decode(base64Image);
      String tempPath = Directory.systemTemp.path;
      String filePath = '$tempPath/${DateTime.now().millisecondsSinceEpoch}.png';
      File file = File(filePath);
      file.writeAsBytesSync(imageBytes);
      return file;
    } else {
      return null;
    }
  }
}