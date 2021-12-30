// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:a_state_graph/src/presentation/state_graph/render_graph.dart';
import 'package:a_state_graph/src/presentation/state_graph/state_graph.dart';
import 'package:flutter/widgets.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  _MyAppState() {
    RenderGraph.initialize(this);
    StateGraph.initialize(() => setState(() => <dynamic>{}));
  }

  @override
  Widget build(BuildContext context) {
    // ignore: cast_nullable_to_non_nullable
    return RenderGraph.build(StateGraph.current()) as Widget;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Future<bool> didPopRoute() {
    StateGraph.reverse();

    return Future<bool>.value(true);
  }
}
