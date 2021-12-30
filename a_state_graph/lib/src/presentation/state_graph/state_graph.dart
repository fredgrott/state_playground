// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:a_state_graph/src/data/repository/api.dart';
import 'package:a_state_graph/src/presentation/state_graph/state_defintions.dart';



// ignore: avoid_classes_with_only_static_members
class StateGraph {
  static late  StateSet _triggerBuild;

  static final List<IState> _state = <IState>[];
  static dynamic initialize(StateSet setState) {
    _triggerBuild = setState;
  }

  static dynamic setInitialState(IState state) {
    _state.add(state);
  }

  static dynamic reverse() {
    _state.removeAt(_state.length - 1);
    // ignore: prefer-last
    _state[_state.length - 1].reverse = true;

    _triggerBuild();
  }

  static dynamic apply(IState state) {
    _state.add(state);
    _triggerBuild();
  }

  // Get token from state graph
  static  ApiState?  apiState() => const ApiState(send, "token",);

  static IState current() {
    // ignore: prefer-last
    return _state[_state.length - 1];
  }
}
