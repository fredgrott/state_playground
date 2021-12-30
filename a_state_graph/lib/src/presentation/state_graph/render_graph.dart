// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.



import 'package:a_state_graph/src/presentation/home/login.dart';
import 'package:a_state_graph/src/presentation/state_graph/state_defintions.dart';
import 'package:flutter/material.dart';

abstract class Transition {
  Widget create(
      Animation<double> animation, Widget from, Widget to, bool reverse,);
}

class PageSlideTransition implements Transition {
  Widget create(
      Animation<double> animation, Widget from, Widget to, bool reverse,) {
    return Stack(textDirection: TextDirection.ltr, children: <Widget>[
      SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: Offset(reverse ? 1.0 : -1.0, 0.0,),
        ).animate(animation),
        child: from,
      ),
      SlideTransition(
        position: Tween<Offset>(
          begin: Offset(reverse ? -1.0 : 1.0, 0.0,),
          end: Offset.zero,
        ).animate(animation),
        child: to,
      ),
    ],);
  }
}

// ignore: avoid_classes_with_only_static_members
class RenderGraph {
  static late Widget _current;
  static late AnimationController _animationController;
  static late TickerProviderStateMixin _state;

  static dynamic initialize(TickerProviderStateMixin state) {
    _state = state;
  }

  static Widget? build(IState state) {
    final buildState = _build(state);
    _current = buildState.widget;


    // ignore: unnecessary_null_comparison
    if (_current == null) {
      _current = buildState.widget;

      return _current;
    } else {
      if (buildState.transition is PageSlideTransition) {
        _animationController = AnimationController(
            vsync: _state, duration: const Duration(milliseconds: 1000),);

        // ignore: cast_nullable_to_non_nullable
        final transition = (buildState.transition as PageSlideTransition).create(
            _animationController, _current, buildState.widget, state.reverse,);

        _current = buildState.widget;

        _animationController.forward();

        state.reverse = false;

        return transition;
      } else {
        return buildState.widget;
      }
    }
  }

  static WidgetState _build(IState state) {
    // Compiled state management
    if (state.branch == Branch.login) {
      return WidgetState(LoginNode.render(state),
          transition: PageSlideTransition(),);
    }

    return WidgetState(_unknownState());
  }

  static Widget _unknownState() {
    return const Center(
        child:
            Text('Entered an unknown state', textDirection: TextDirection.ltr,),);
  }
}

class WidgetState {
  final Widget widget;
  final Transition? transition;

  WidgetState(this.widget, {this.transition,});

  
}
