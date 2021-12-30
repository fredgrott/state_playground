import 'package:a_state_graph/src/myapp.dart';
import 'package:a_state_graph/src/presentation/home/login.dart';
import 'package:a_state_graph/src/presentation/state_graph/state_graph.dart';
import 'package:flutter/material.dart';

void main() {
  StateGraph.setInitialState(DefaultLoginState());

  runApp(const MyApp());
}
