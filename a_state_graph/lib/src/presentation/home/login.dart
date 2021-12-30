// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:a_state_graph/src/data/repository/account.dart';
import 'package:a_state_graph/src/data/repository/api.dart';
import 'package:a_state_graph/src/presentation/state_graph/state_defintions.dart';
import 'package:a_state_graph/src/presentation/state_graph/state_graph.dart';

import 'package:flutter/material.dart';

class DefaultLoginState extends IState {
  @override
  // ignore: overridden_fields
  Branch branch = Branch.login;
}

class LoginErrorState extends DefaultLoginState {
  String loginErrorMessage = "There was an error";
}

typedef LoginFunction = IState Function(
  LoginRequest loginRequest,
  String username,
  String password,
);

// ignore: avoid_classes_with_only_static_members
class LoginNode {
  static Widget render(IState state) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _render(state),
    );

    
  }

  static IState login(
    LoginRequest loginRequest,
    String username,
    String password,
  ) {
    final result = loginRequest(
      username,
      password,
    );

    // ignore: no-boolean-literal-compare
    if (result == false) {
      // Do some logic
      return LoginErrorState();
    }

    return DefaultLoginState();
  }

  static Widget _render(IState state) {
    if (state is LoginErrorState) {
      return Container(
        padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png',
              ),
              Text(
                state.loginErrorMessage,
                textDirection: TextDirection.ltr,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png',
              ),
              TextButton(
                child: const Text(
                  'Login',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => StateGraph.apply(
                  login(
                    // ignore: cast_nullable_to_non_nullable
                    Account.login(StateGraph.apiState() as ApiState),
                    "username",
                    "password",
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
