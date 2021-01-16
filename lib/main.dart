// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:captainpassword/credentials.dart';
import 'package:flutter/material.dart';
import 'package:captainpassword/captainpassword/app.dart';
import 'package:captainpassword/captainpassword/locator.dart';
import 'package:rehana/helpers/security.dart';

void main() {
  setupLocator();
  Security.initialize(Credentials.AES_IV);
  runApp(Application());
}
