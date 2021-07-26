// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'routing.dart';
import 'screens.dart';

void main() => runApp(const Bookstore());

class Bookstore extends StatefulWidget {
  const Bookstore({Key? key}) : super(key: key);

  @override
  _BookstoreState createState() => _BookstoreState();
}

class _BookstoreState extends State<Bookstore> {
  late final RouteState routeState;
  late final SimpleRouterDelegate routerDelegate;
  late final TemplateRouteParser routeParser;
  // final navless = true; // smooth nested navigation, no Back button
  final navless = false; // no nested navigation, Back button

  @override
  void initState() {
    routeParser = TemplateRouteParser(
      allowedPaths: [if (!navless) '/', '/new', '/all', '/popular'],
      initialRoute: navless ? '/popular' : '/',
    );

    routeState = RouteState(routeParser);

    routerDelegate = SimpleRouterDelegate(
      routeState: routeState,
      builder: navless ? _navlessBuilder : _navfullBuilder,
    );

    super.initState();
  }

  // this works great; it only transitions the change on the page. however, it
  // has no concept of Back
  Widget _navlessBuilder(BuildContext context) {
    final path = RouteStateScope.of(context)!.route.path;
    return BooksScreen(path);
  }

  // this causes the whole page to transition, but does enable the Back button
  Widget _navfullBuilder(BuildContext context) {
    final path = RouteStateScope.of(context)!.route.path;
    return Navigator(
      pages: [
        const MaterialPage<void>(key: ValueKey('/'), child: HomeScreen()),
        if (path != '/')
          MaterialPage<void>(key: ValueKey(path), child: BooksScreen(path))
      ],
      onPopPage: (route, dynamic result) {
        if (!route.didPop(result)) return false;
        routeState.go('/');
        return true;
      },
    );
  }

  @override
  Widget build(BuildContext context) => RouteStateScope(
        notifier: routeState,
        child: MaterialApp.router(
          routerDelegate: routerDelegate,
          routeInformationParser: routeParser,
        ),
      );

  @override
  void dispose() {
    routeState.dispose();
    routerDelegate.dispose();
    super.dispose();
  }
}
