// Copyright (c) 2017, rreed. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'package:crypto/crypto.dart';

hash1() {
  List<int> bytes = UTF8.encode('message');
  String hash = sha256.convert(bytes).toString();
  assert(hash == 'ab530a13e45914982b79f9b7e3fba994cfd1f3fb22f71cea1afbf02b460c6d1d');  // true
  print(hash);
}



int calculate() {
  return 6 * 7;
}