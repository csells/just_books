// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'parsed_route.dart';
import 'route_state.dart';

class SimpleRouterDelegate extends RouterDelegate<ParsedRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<ParsedRoute> {
  final RouteState routeState;
  final WidgetBuilder builder;

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  SimpleRouterDelegate({
    required this.routeState,
    required this.builder,
    // ignore: prefer_initializing_formals
  }) {
    routeState.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }

  @override
  Future<void> setNewRoutePath(ParsedRoute configuration) async {
    routeState.route = configuration;
  }

  @override
  ParsedRoute get currentConfiguration {
    return routeState.route;
  }

  @override
  void dispose() {
    routeState.removeListener(notifyListeners);
    routeState.dispose();
    super.dispose();
  }
}
