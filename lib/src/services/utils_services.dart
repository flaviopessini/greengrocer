import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

abstract class UtilsServices {
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

  static void showToast({required String message, bool isError=false}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: isError ? Colors.redAccent : Colors.greenAccent,
        textColor: Colors.black,
        fontSize: 16.0,
    );
  }
}
