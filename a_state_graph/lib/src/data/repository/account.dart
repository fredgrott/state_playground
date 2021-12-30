// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:a_state_graph/src/data/repository/api.dart';

typedef LoginRequest = bool Function(String username, String password,);

// ignore: avoid_classes_with_only_static_members
class Account {
  static LoginRequest login(ApiState apiState) => (username, password,) =>
      _login(apiState.send, apiState.token, username, password,);

  static bool _login(
      HttpSend send, String token, String username, String password) {
    final request = Request("/v1/login", token,);
    // Add in username and password to request

    final response = send(request);
    if (response.code == 200) {
      return true;
    } else {
      return false;
    }
  }
}
