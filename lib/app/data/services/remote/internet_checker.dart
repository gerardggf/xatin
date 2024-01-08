// coverage:ignore-file
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final internetCheckerProvider = Provider<InternetChecker>(
  (ref) => InternetChecker(),
);

class InternetChecker {
  Future<bool> hasInternet() async {
    try {
      if (kIsWeb) {
        final response = await get(
          Uri.parse('8.8.8.8'),
        );
        return response.statusCode == 200;
      } else {
        final list = await InternetAddress.lookup('google.com');
        return list.isNotEmpty && list.first.rawAddress.isNotEmpty;
      }
    } catch (e) {
      return false;
    }
  }
}
