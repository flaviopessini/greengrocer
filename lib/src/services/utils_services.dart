import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

abstract class UtilsServices {
  static const storage = FlutterSecureStorage();

  static Future<void> saveLocalData(
      {required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  static Future<String?> getLocalData(String key) async {
    return await storage.read(key: key);
  }

  static Future<void> removeLocalData(String key) async {
    await storage.delete(key: key);
  }

  static String priceToCurrency(double price) {
    return NumberFormat.simpleCurrency(locale: 'pt_BR').format(price);
  }

  static String formatDateTime(DateTime dateTime) {
    try {
      initializeDateFormatting();
      DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
      return dateFormat.format(dateTime);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return '??/??/???? ??:??';
    }
  }

  static final phoneFormatter = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  static final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  static void showToast({required String message, bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: isError ? Colors.red.shade800 : Colors.green.shade800,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static Uint8List showQrCodeImage(String data) {
    String base64String = data.split(',').last;

    return base64Decode(base64String);
  }
}
